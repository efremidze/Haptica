//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 4/7/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit
import Haptic

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.isHaptic = true
        }
    }
    
}

