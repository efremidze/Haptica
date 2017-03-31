//
//  ViewController.swift
//  Test
//
//  Created by Lasha Efremidze on 3/31/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var button: UIButton! {
//        didSet {
//            
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapped(_ button: UIButton) {
        Haptic.selection.generate()
    }
    
}

//protocol Haptic {
//    var isHaptic: Bool { get set }
//}
//
//extension UIButton: Haptic {}

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
    
//    func handle(state: UIGestureRecognizerState) {
//        switch state {
//        case .began:
//            feedbackGenerator = UISelectionFeedbackGenerator()
//            feedbackGenerator?.prepare()
//        case .changed:
//            feedbackGenerator?.selectionChanged()
//            feedbackGenerator?.prepare()
//        case .cancelled, .ended, .failed:
//            feedbackGenerator = nil
//        default:
//            break
//        }
//    }
}

//private extension UIFeedbackGenerator {
//    static func impactFeedbackGenerator(style: UIImpactFeedbackStyle) -> UIImpactFeedbackGenerator {
//        return impactFeedbackGenerators[style.rawValue]
//    }
//    private static let impactFeedbackGenerators = [UIImpactFeedbackGenerator(style: .light), UIImpactFeedbackGenerator(style: .medium), UIImpactFeedbackGenerator(style: .heavy)]
//    static let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
//    static let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
//}
