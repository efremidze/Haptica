//
//  Extensions.swift
//  Haptica
//
//  Created by Lasha Efremidze on 8/16/18.
//  Copyright © 2018 efremidze. All rights reserved.
//

import UIKit

extension UIControlEvents: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
}

func == (lhs: UIControlEvents, rhs: UIControlEvents) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
