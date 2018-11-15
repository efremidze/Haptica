//
//  Haptic.swift
//  Haptica
//
//  Created by Lasha Efremidze on 4/7/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

public enum HapticStyle: Int {
    case light, medium, heavy
}

public enum FeedbackType: Int {
    case success, warning, error
}

public enum Haptic {
    case impact(HapticStyle)
    case notification(FeedbackType)
    case selection
    
    // trigger
    public func generate() {
        guard #available(iOS 10, *) else { return }
        
        switch self {
        case .impact(let style):
            guard let impactStyle = UIImpactFeedbackGenerator.FeedbackStyle.init(rawValue: style.rawValue) else {
                return
            }
            let generator = UIImpactFeedbackGenerator(style: impactStyle)
            generator.prepare()
            generator.impactOccurred()
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            guard let feedbackType = UINotificationFeedbackGenerator.FeedbackType.init(rawValue: type.rawValue) else {
                return
            }
            generator.notificationOccurred(feedbackType)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}
