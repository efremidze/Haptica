//
//  ViewController.swift
//  Test
//
//  Created by Lasha Efremidze on 3/31/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.isHaptic = true
        }
    }
    
}
