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
            for target in allTargets {
                if let actions = actions(forTarget: target, forControlEvent: _hapticControlEvents) {
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
                addTarget(self, action: #selector(trigger), for: _hapticControlEvents)
            } else {
                removeTarget(self, action: #selector(trigger), for: _hapticControlEvents)
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
    
    fileprivate var _hapticType: Haptic {
        return hapticType ?? .selection
    }
    
    fileprivate var _hapticControlEvents: UIControlEvents {
        return hapticControlEvents ?? .touchDown
    }
    
}

extension UIButton: Hapticable {
    
    public func trigger(_ sender: Any) {
        _hapticType.generate()
    }
    
}
