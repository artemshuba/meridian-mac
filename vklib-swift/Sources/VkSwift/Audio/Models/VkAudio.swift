//
//  VkAudio.swift
//  
//
//  Created by Artem Shuba on 29/03/2020.
//

public struct VkAudio : Codable {
    public let id: Int
    
    public let title: String
    
    public let artist: String
    
    public let duration: Double
    
    public let url: String?
    
    public let accessKey: String?
    
    public let album: VkAudioAlbum?
    
    public init(id: Int, title: String, artist: String, duration: Double, url: String?, accessKey: String?, album: VkAudioAlbum?) {
        self.id = id
        self.title = title
        self.artist = artist
        self.duration = duration
        self.url = url
        self.accessKey = accessKey
        self.album = album
    }
}
