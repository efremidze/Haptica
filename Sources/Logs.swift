//
//  Logs.swift
//  Haptica
//
//  Created by Lasha Efremidze on 5/2/25.
//  Copyright © 2025 efremidze. All rights reserved.
//

import os.log

enum HapticaLog {
    static var isEnabled = true // or conditionally compile with DEBUG flag

    static func info(_ message: String) {
        if isEnabled { print("[Haptica] \(message)") }
    }

    static func error(_ message: String) {
        if isEnabled { print("[Haptica ❌] \(message)") }
    }
}
