//
//  UserDefaultsStorage.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

/// Stores values in UserDefaults
class UserDefaultsStorage : KeyValueStorage {
    private let userDefaults: UserDefaults
    
    init(_ userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func value<T>(forKey key: String) -> T? where T: Decodable {
        guard hasValue(forKey: key) else { return nil }
        
        switch T.self {
        case is String.Type:
            return userDefaults.string(forKey: key) as? T
        case is Bool.Type:
            return userDefaults.bool(forKey: key) as? T
        case is Int.Type:
            return userDefaults.integer(forKey: key) as? T
        case is Float.Type:
            return userDefaults.float(forKey: key) as? T
        case is Double.Type:
            return userDefaults.double(forKey: key) as? T
        case is Data.Type:
            return userDefaults.data(forKey: key) as? T
        default:
            guard let value = userDefaults.value(forKey: key) else { return nil }
            guard let jsonData = value as? Data else {
                return value as? T
            }
            
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(T.self, from: jsonData)
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    func set<T>(_ value: T, forKey key: String) where T: Encodable {
        switch T.self {
            // If it's a standard type, just store it
        case is String.Type,
             is Bool.Type,
             is Int.Type,
             is Float.Type,
             is Double.Type,
             is Data.Type:
            userDefaults.set(value, forKey: key)
            // If not, store it as a json
        default:
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(value)
                userDefaults.set(data, forKey: key)
            } catch {
                print(error)
            }
        }
    }
    
    func clearValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    private func hasValue(forKey key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}
