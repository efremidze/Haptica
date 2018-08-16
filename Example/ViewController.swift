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
            selection.addHaptic(.selection, forControlEvents: .touchDown)
        }
    }
    
    @IBOutlet weak var impactLight: UIButton! {
        didSet {
            impactLight.addHaptic(.impact(.light), forControlEvents: .touchDown)
        }
    }

    @IBOutlet weak var impactMedium: UIButton! {
        didSet {
            impactMedium.addHaptic(.impact(.medium), forControlEvents: .touchDown)
        }
    }

    @IBOutlet weak var impactHeavy: UIButton! {
        didSet {
            impactHeavy.addHaptic(.impact(.heavy), forControlEvents: .touchDown)
        }
    }

    @IBOutlet weak var notificationSuccess: UIButton! {
        didSet {
            notificationSuccess.addHaptic(.notification(.success), forControlEvents: .touchDown)
        }
    }

    @IBOutlet weak var notificationWarning: UIButton! {
        didSet {
            notificationWarning.addHaptic(.notification(.warning), forControlEvents: .touchDown)
        }
    }

    @IBOutlet weak var notificationError: UIButton! {
        didSet {
            notificationError.addHaptic(.notification(.error), forControlEvents: .touchDown)
        }
    }
    
}
