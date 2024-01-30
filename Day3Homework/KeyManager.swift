//
//  KeyManager.swift
//  Day3Homework
//
//  Created by Hina KONISHI on 2024/01/23.
//

import SwiftUI

struct KeyManager {
    private static let keyFilePath = Bundle.main.path(forResource: "APIkey", ofType: "plist")

    static func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }

    static func getValue(key: String) -> AnyObject? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key]! as AnyObject
    }
}
