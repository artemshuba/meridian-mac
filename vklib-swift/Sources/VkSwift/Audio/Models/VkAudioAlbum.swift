//
//  VkAudioAlbum.swift
//  
//
//  Created by Artem Shuba on 27/05/2020.
//

import Foundation

public struct VkAudioAlbum : Codable {
    public let ownerId: Int
    
    public let id: Int
    
    public let title: String
    
    public let accessKey: String?
    
    public let thumb: VkThumb?
}
