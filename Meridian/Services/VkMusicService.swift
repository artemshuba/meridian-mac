//
//  VkMusicService.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class VkMusicService {
    private let vk: VkApi
    
    init(vk: VkApi) {
        self.vk = vk
    }
    
    func fetchTracks(completion: @escaping (Result<VkAudioResponse, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let result = self.vk.fetchAudios()
            completion(result)
        }
    }
    
    func fetchPopularTracks(completion: @escaping (Result<[VkAudio], Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let result = self.vk.fetchPopularAudios()
            completion(result)
        }
    }
}
