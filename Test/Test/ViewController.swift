//
//  ViewController.swift
//  Test
//
//  Created by Lasha Efremidze on 3/31/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapped(_ button: UIButton) {
        button.isHaptic = true
        if button.isHaptic {
            print("--->")
        }
//        button.isHaptic = false
//        if button.isHaptic {
//            print("--->")
//        }
    }
    
}

enum Haptic {
    case impact(UIImpactFeedbackStyle)
    case notification(UINotificationFeedbackType)
    case selection
    
    // trigger
    func generate() {
        switch self {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}

protocol Hapticable {
    var isHaptic: Bool { get set }
}

extension UIButton: Hapticable {
    var isHaptic: Bool {
        get {
            for target in allTargets {
                if let actions = actions(forTarget: target, forControlEvent: .touchDown) {
                    for action in actions {
                        if action == #selector(trigger).description {
                            return true
                        }
                    }
                }
            }
            return false
        }
        set {
            if newValue {
                addTarget(self, action: #selector(trigger), for: .touchDown)
            } else {
                removeTarget(self, action: #selector(trigger), for: .touchDown)
            }
        }
    }
    
    func trigger(_ button: UIButton) {
        Haptic.impact(.heavy).generate()
    }
}
