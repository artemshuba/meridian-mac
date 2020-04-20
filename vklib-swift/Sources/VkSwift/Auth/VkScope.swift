//
//  VkScope.swift
//  
//
//  Created by Artem Shuba on 29/03/2020.
//

public struct VkScope : OptionSet {
    public let rawValue: Int
    
    public static let canNotify = VkScope(rawValue: 1 << 0)
    public static let canAccessFriends = VkScope(rawValue: 1 << 1)
    public static let canAccessPhotos = VkScope(rawValue: 1 << 2)
    public static let canAccessAudios = VkScope(rawValue: 1 << 3)
    /* ... */
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
