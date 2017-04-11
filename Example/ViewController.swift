//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 4/7/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit
import Haptica

class ViewController: UIViewController {
    
    @IBOutlet weak var selection: UIButton! {
        didSet {
            selection.isHaptic = true
            selection.hapticType = .selection
        }
    }
    
    @IBOutlet weak var impactLight: UIButton! {
        didSet {
            impactLight.isHaptic = true
            impactLight.hapticType = .impact(.light)
        }
    }

    @IBOutlet weak var impactMedium: UIButton! {
        didSet {
            impactMedium.isHaptic = true
            impactMedium.hapticType = .impact(.medium)
        }
    }

    @IBOutlet weak var impactHeavy: UIButton! {
        didSet {
            impactHeavy.isHaptic = true
            impactHeavy.hapticType = .impact(.heavy)
        }
    }

    @IBOutlet weak var notificationSuccess: UIButton! {
        didSet {
            notificationSuccess.isHaptic = true
            notificationSuccess.hapticType = .notification(.success)
        }
    }

    @IBOutlet weak var notificationWarning: UIButton! {
        didSet {
            notificationWarning.isHaptic = true
            notificationWarning.hapticType = .notification(.warning)
        }
    }

    @IBOutlet weak var notificationError: UIButton! {
        didSet {
            notificationError.isHaptic = true
            notificationError.hapticType = .notification(.error)
        }
    }
    
}
