//
//  VkAccessToken.swift
//  
//
//  Created by Artem Shuba on 29/03/2020.
//

public struct VkAccessToken : Codable {
    public let accessToken: String
    
    public let userId: Int
    
    public init(accessToken: String, userId: Int) {
        self.accessToken = accessToken
        self.userId = userId
    }
}
