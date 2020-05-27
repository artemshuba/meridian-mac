//
//  MyMusicPresenter.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class MyMusicPresenter : Presenter {
    private let vkMusicService: VkMusicService
    private let audioPlayer: AudioPlayer
    
    private (set) var tracks: [Track] = []
    
    weak var view: MyMusicView?
    
    init(vkMusicService: VkMusicService, audioPlayer: AudioPlayer) {
        self.vkMusicService = vkMusicService
        self.audioPlayer = audioPlayer
    }
    
    func load() {
        loadTracks()
    }
    
    func selectTrack(at indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        
        audioPlayer.play(track: track, from: tracks)
    }
    
    private func loadTracks() {
        vkMusicService.fetchTracks { [weak self] result in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                
                switch result {
                case .success(let response):
                    self.tracks = response.items.map { Track(vkAudio: $0) }
                    self.view?.reload()
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}
