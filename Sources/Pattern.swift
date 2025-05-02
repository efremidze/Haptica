//
//  Pattern.swift
//  Haptica
//
//  Created by Lasha Efremidze on 1/17/19.
//  Copyright © 2019 efremidze. All rights reserved.
//

import CoreHaptics

public extension Haptic {
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

public extension Haptic {
    static let queue: OperationQueue = .serial
    
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

public enum LegacyNote {
    case haptic(Haptic)
    case wait(TimeInterval)
    
    init?(_ char: Character, delay: TimeInterval) {
        switch String(char) {
        case "O":
            self = .haptic(.impact(.heavy))
        case "o":
            self = .haptic(.impact(.medium))
        case ".":
            self = .haptic(.impact(.light))
        case "X":
            self = .haptic(.impact(.rigid))
        case "x":
            self = .haptic(.impact(.soft))
        case "-":
            self = .wait(delay)
        default:
            return nil
        }
    }
    
    var operation: Operation {
        switch self {
        case .haptic(let haptic):
            return HapticOperation(haptic)
        case .wait(let interval):
            return WaitOperation(interval)
        }
    }
}

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

class WaitOperation: Operation, @unchecked Sendable {
    let duration: TimeInterval
    init(_ duration: TimeInterval) {
        self.duration = duration
    }
    override func main() {
        Thread.sleep(forTimeInterval: duration)
    }
}

import CoreHaptics

public extension Haptic {
    static var engine: CHHapticEngine?
    
    static func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            // The engine stops automatically when it goes into the background
            engine?.stoppedHandler = { reason in
                print("Haptic engine stopped: \(reason)")
            }
            
            engine?.resetHandler = {
                print("Haptic engine reset")
                do {
                    try engine?.start()
                } catch {
                    print("Failed to restart engine: \(error)")
                }
            }
        } catch {
            print("Failed to create haptic engine: \(error)")
        }
    }
    
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
            print("Failed to play pattern: \(error)")
        }
    }
}

public enum Note {
    case haptic(Float, Float) // intensity, sharpness
    case wait(TimeInterval)
    
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
