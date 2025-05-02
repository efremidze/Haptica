//
//  Haptic.swift
//  Haptica
//
//  Created by Lasha Efremidze on 4/7/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

/// Describes impact feedback styles with varying intensity.
public enum HapticFeedbackStyle: Int {
    case light, medium, heavy
    case soft, rigid
}

extension HapticFeedbackStyle {
    var value: UIImpactFeedbackGenerator.FeedbackStyle {
        return UIImpactFeedbackGenerator.FeedbackStyle(rawValue: rawValue)!
    }
}

/// Describes notification feedback types for task outcomes.
public enum HapticFeedbackType: Int {
    case success, warning, error
}

extension HapticFeedbackType {
    var value: UINotificationFeedbackGenerator.FeedbackType {
        return UINotificationFeedbackGenerator.FeedbackType(rawValue: rawValue)!
    }
}

/// Primary interface for generating haptic feedback in Haptica.
public enum Haptic {
    case impact(HapticFeedbackStyle)
    case notification(HapticFeedbackType)
    case selection
    
    // Semantic variants
    case start
    case stop
    case increase
    case decrease
    case success
    case failure
    case warning
    
    /// Triggers the haptic feedback corresponding to the case.
    public func generate() {
        switch self {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style.value)
            generator.prepare()
            generator.impactOccurred()
            
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type.value)
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
            
            // Semantic mappings
        case .start:
            Haptic.impact(.medium).generate()
        case .stop:
            Haptic.impact(.rigid).generate()
        case .increase:
            Haptic.impact(.light).generate()
        case .decrease:
            Haptic.impact(.soft).generate()
        case .success:
            Haptic.notification(.success).generate()
        case .failure:
            Haptic.notification(.error).generate()
        case .warning:
            Haptic.notification(.warning).generate()
        }
    }
}
