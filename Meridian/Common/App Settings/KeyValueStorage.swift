//
//  KeyValueStorage.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

/// Defines a protocol for key-value storage
protocol KeyValueStorage {
    /// Returns value for key
    func value<T>(forKey key: String) -> T? where T: Decodable
    
    /// Stores value for key
    func set<T>(_ value: T, forKey key: String) where T: Encodable
    
    /// Clears value for key
    func clearValue(forKey key: String)
}
