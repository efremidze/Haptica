//
//  Pattern.swift
//  Haptica
//
//  Created by Lasha Efremidze on 1/17/19.
//  Copyright © 2019 efremidze. All rights reserved.
//

import CoreHaptics

// MARK: - Haptic Pattern API

public extension Haptic {
    /// Generates a sequence of haptic events from a symbolic string pattern.
    ///
    /// - Parameters:
    ///   - pattern: A string representing haptic feedback (e.g., `"..oO-Oo.."`)
    ///   - delay: The delay used between pattern symbols like `-`
    ///   - legacy: Whether to use legacy (UIKit) haptics instead of Core Haptics
    static func play(_ pattern: String, delay: TimeInterval, legacy: Bool = false) {
        if legacy {
            let notes = pattern.compactMap { LegacyNote($0, delay: delay) }
            play(notes)
        } else {
            let notes = pattern.compactMap { Note($0, delay: delay) }
            play(notes)
        }
    }
}

// MARK: - Core Haptics Engine

public extension Haptic {
    /// The shared Core Haptics engine instance used by the framework.
    static var engine: CHHapticEngine?
    
    /// Prepares and starts the Core Haptics engine.
    /// Sets up handlers to automatically restart the engine on reset or failure.
    static func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            engine?.resetHandler = {
                do {
                    try engine?.start()
                } catch {
                    HapticaLog.error("Failed to restart engine: \(error)")
                }
            }
        } catch {
            HapticaLog.error("Failed to create haptic engine: \(error)")
        }
    }
    
    /// Plays a sequence of haptic notes using Core Haptics.
    ///
    /// - Parameter notes: An array of `Note` values that represent haptic and wait commands.
    static func play(_ notes: [Note]) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        if engine == nil {
            prepareHaptics()
        }
        
        guard let engine else { return }
        
        do {
            var events = [CHHapticEvent]()
            var currentTime: TimeInterval = 0
            
            for note in notes {
                switch note {
                case .haptic(let intensity, let sharpness):
                    // Create and add haptic event
                    let event = CHHapticEvent(
                        eventType: .hapticTransient,
                        parameters: [
                            CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                            CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
                        ],
                        relativeTime: currentTime
                    )
                    events.append(event)
                    currentTime += 0.1 // Default duration for transient events
                    
                case .wait(let interval):
                    currentTime += interval
                }
            }
            
            // Create pattern from events
            let pattern = try CHHapticPattern(events: events, parameters: [])
            
            // Create player and play pattern
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            HapticaLog.error("Failed to play pattern: \(error)")
        }
    }
}

// MARK: - Legacy Engine

public extension Haptic {
    /// A serial queue used to sequence legacy haptic operations.
    static let queue: OperationQueue = .serial
    
    /// Plays a series of `LegacyNote` values using UIKit-based feedback generators.
    ///
    /// - Parameter notes: An array of legacy haptic notes.
    static func play(_ notes: [LegacyNote]) {
        guard queue.operations.isEmpty else { return }
        
        for note in notes {
            let operation = note.operation
            if let last = queue.operations.last {
                operation.addDependency(last)
            }
            queue.addOperation(operation)
        }
    }
}

// MARK: - Notes

/// A note in a Core Haptics pattern, representing either a haptic feedback or a wait.
///
/// `Note` is constructed from symbolic characters to support pattern string parsing.
public enum Note {
    case haptic(Float, Float) // intensity, sharpness
    case wait(TimeInterval)
    
    /// Initializes a `Note` from a pattern character and delay.
    ///
    /// - Parameters:
    ///   - char: A character representing a feedback type.
    ///   - delay: The duration to wait for wait notes (e.g. `-`).
    init?(_ char: Character, delay: TimeInterval) {
        switch String(char) {
        case "O":
            self = .haptic(1.0, 0.7) // Heavy impact - high intensity, medium-high sharpness
        case "o":
            self = .haptic(0.7, 0.5) // Medium impact - medium intensity, medium sharpness
        case ".":
            self = .haptic(0.4, 0.4) // Light impact - low intensity, medium-low sharpness
        case "X":
            self = .haptic(0.8, 0.9) // Rigid impact - high-medium intensity, high sharpness
        case "x":
            self = .haptic(0.4, 0.2) // Soft impact - low intensity, low sharpness
        case "-":
            self = .wait(delay)
        default:
            return nil
        }
    }
}

public extension Haptic {
    var hapticNote: Note? {
        switch self {
        case .start:
            return .haptic(0.6, 0.6)
        case .stop:
            return .haptic(0.9, 0.8)
        case .increase:
            return .haptic(0.5, 0.4)
        case .decrease:
            return .haptic(0.3, 0.3)
        case .success:
            return .haptic(1.0, 0.7)
        case .failure:
            return .haptic(0.9, 0.5)
        case .warning:
            return .haptic(0.9, 1.0)
        default:
            return nil // handled elsewhere
        }
    }
}

/// A note in the legacy haptic pattern system, using UIKit feedback types.
public enum LegacyNote {
    case haptic(Haptic)
    case wait(TimeInterval)
    
    /// Initializes a `LegacyNote` from a pattern character and delay.
    ///
    /// - Parameters:
    ///   - char: A character representing a feedback type.
    ///   - delay: The duration to wait for wait notes (e.g. `-`).
    init?(_ char: Character, delay: TimeInterval) {
        switch char {
        case "O": self = .haptic(.impact(.heavy))
        case "o": self = .haptic(.impact(.medium))
        case ".": self = .haptic(.impact(.light))
        case "X": self = .haptic(.impact(.rigid))
        case "x": self = .haptic(.impact(.soft))
        case "-": self = .wait(delay)
        default: return nil
        }
    }
    
    /// Converts the `LegacyNote` into a queued operation.
    var operation: Operation {
        switch self {
        case .haptic(let haptic):
            return HapticOperation(haptic)
        case .wait(let interval):
            return WaitOperation(interval)
        }
    }
}

// MARK: - Operation Wrappers

/// An `Operation` that triggers a UIKit-based haptic feedback when executed.
class HapticOperation: Operation, @unchecked Sendable {
    let haptic: Haptic
    init(_ haptic: Haptic) {
        self.haptic = haptic
    }
    override func main() {
        DispatchQueue.main.sync {
            self.haptic.generate()
        }
    }
}

/// An `Operation` that waits (sleeps) for a specified time when executed.
class WaitOperation: Operation, @unchecked Sendable {
    let duration: TimeInterval
    init(_ duration: TimeInterval) {
        self.duration = duration
    }
    override func main() {
        Thread.sleep(forTimeInterval: duration)
    }
}
