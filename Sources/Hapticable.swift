//
//  Hapticable.swift
//  Haptica
//
//  Created by Lasha Efremidze on 4/7/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

private var hapticKey: Void?
private var eventKey: Void?
private var targetsKey: Void?

public protocol Hapticable: class {
    func trigger(_ sender: Any)
}

extension Hapticable where Self: UIControl {
    
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
    
    private var hapticTargets: [UIControlEvents: HapticTarget] {
        get { return getAssociatedObject(&targetsKey) ?? [:] }
        set { setAssociatedObject(&targetsKey, newValue) }
    }
    
    public func addHaptic(_ haptic: Haptic, forControlEvents events: UIControlEvents) {
        let hapticTarget = HapticTarget(haptic: haptic)
        hapticTargets[events] = hapticTarget
        addTarget(hapticTarget, action: #selector(hapticTarget.trigger), for: events)
    }
    
    public func removeHaptic(forControlEvents events: UIControlEvents) {
        guard let hapticTarget = hapticTargets[events] else { return }
        hapticTargets[events] = nil
        removeTarget(hapticTarget, action: #selector(hapticTarget.trigger), for: events)
    }
    
}

extension UIControl: Hapticable {
    @objc public func trigger(_ sender: Any) {
        hapticType?.generate()
    }
}

private class HapticTarget {
    let haptic: Haptic
    init(haptic: Haptic) {
        self.haptic = haptic
    }
    @objc func trigger(_ sender: Any) {
        haptic.generate()
    }
}
