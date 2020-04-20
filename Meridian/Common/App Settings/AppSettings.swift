//
//  AppSettings.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class AppSettings {
    private enum AppSettingsKey : String {
        case authToken
    }
    
    private let storage: KeyValueStorage
    
    /// Access token
    var accessToken: VkAccessToken? {
        get { value(forKey: .authToken) }
        set { set(newValue, forKey: .authToken) }
    }
    
    init(storage: KeyValueStorage) {
        self.storage = storage
    }
    
    // MARK: - Private
    
    private func value<T>(forKey key: AppSettingsKey) -> T? where T: Decodable {
        return storage.value(forKey: key.rawValue)
    }
    
    private func set<T>(_ value: T, forKey key: AppSettingsKey) where T: Encodable {
        storage.set(value, forKey: key.rawValue)
    }
}
