//
//  TrackViewModel.swift
//  Meridian
//
//  Created by Artem Shuba on 27/05/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

struct Track {
    let id: Int
    
    let title: String
    
    let artist: String
    
    let duration: TimeInterval
    
    let displayDuration: String
    
    let url: URL?
    
    init(id: Int, title: String, artist: String, duration: TimeInterval, url: URL?) {
        self.id = id
        self.title = title
        self.artist = artist
        self.duration = duration
        self.displayDuration = duration.durationString
        self.url = url
    }
}

extension Track {
    init(vkAudio: VkAudio) {
        var url: URL?
        
        if let urlString = vkAudio.url {
            url = URL(string: urlString)
        }
        
        self.init(id: vkAudio.id,
                  title: vkAudio.title,
                  artist: vkAudio.artist,
                  duration: vkAudio.duration,
                  url: url)
    }
}
