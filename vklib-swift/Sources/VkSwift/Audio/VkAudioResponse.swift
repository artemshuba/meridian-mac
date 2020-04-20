//
//  VkAudioResponse.swift
//  
//
//  Created by Artem Shuba on 29/03/2020.
//

public struct VkAudioResponse : Codable {
    public let items: [VkAudio]
    
    public init(items: [VkAudio]) {
        self.items = items
    }
}
