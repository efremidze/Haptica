//
//  Hapticable.swift
//  Test
//
//  Created by Lasha Efremidze on 4/7/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

private var hapticKey: Void?
private var eventKey: Void?

public protocol Hapticable {
    func trigger(_ sender: Any)
}

extension Hapticable where Self: UIButton {
    
    public var isHaptic: Bool {
        get {
            guard let actions = actions(forTarget: self, forControlEvent: hapticControlEvents ?? .touchDown) else { return false }
            return !actions.filter { $0 == #selector(trigger).description }.isEmpty
        }
        set {
            if newValue {
                addTarget(self, action: #selector(trigger), for: hapticControlEvents ?? .touchDown)
            } else {
                removeTarget(self, action: #selector(trigger), for: hapticControlEvents ?? .touchDown)
            }
        }
    }
    
    public var hapticType: Haptic? {
        get { return getAssociatedObject(&hapticKey) }
        set { setAssociatedObject(&hapticKey, newValue) }
    }
    
    public var hapticControlEvents: UIControlEvents? {
        get { return getAssociatedObject(&eventKey) }
        set { setAssociatedObject(&eventKey, newValue) }
    }
    
}

extension UIButton: Hapticable {
    
    @objc public func trigger(_ sender: Any) {
        hapticType?.generate()
    }
    
}
