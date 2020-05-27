//
//  AudioPlayer.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

protocol AudioPlayerDelegate : class {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeState isPlaying: Bool)
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeCurrentTrack track: Track?)
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangePositionTo position: TimeInterval)
}

class AudioPlayer {
    private var player: AVPlayer
    private var playlist: [Track] = []
    private let commandCenter = MPRemoteCommandCenter.shared()
    private var timer: Timer?
    
    private var currentTrack: Track? {
        didSet {
            delegate?.audioPlayer(self, didChangeCurrentTrack: currentTrack)
            
            guard let track = self.currentTrack else { return }
            setNowPlayingPlaybackInfo(track)
        }
    }
    
    weak var delegate: AudioPlayerDelegate?
    
    var isPlaying: Bool = false {
        didSet {
            delegate?.audioPlayer(self, didChangeState: isPlaying)

            guard let track = self.currentTrack else { return }
            setNowPlayingPlaybackInfo(track)
        }
    }
    
    init() {
        self.player = AVPlayer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        setupRemoteTransportControls()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func setPlaylist(tracks: [Track]) {
        playlist = tracks
    }
    
    func play(track: Track, from tracks: [Track]) {
        self.playlist = tracks
        self.currentTrack = track
        
        let item = playerItem(from: track)

        player.replaceCurrentItem(with: item)
        play()
    }
    
    func play() {
        player.play()
        isPlaying = true
        startTimer()
    }
    
    func pause() {
        player.pause()
        isPlaying = false
        timer?.invalidate()
    }
    
    func switchPrevious() {
        guard let currentTrack = self.currentTrack else { return }
        
        let positionSeconds = player.currentTime().seconds
        
        // If more than 3 seconds played from track's beginning, go to the beginning
        if (positionSeconds >= 3) {
            player.seek(to: .zero)
            return
        }
        
        var index = playlist.firstIndex(where: { $0.id == currentTrack.id }) ?? 0
        index -= 1
        
        guard index >= 0 else { return }
        
        let prevTrack = playlist[index]
        let item = playerItem(from: prevTrack)
        
        self.currentTrack = prevTrack
        
        player.replaceCurrentItem(with: item)
        play()
    }
    
    func switchNext() {
        guard let currentTrack = self.currentTrack else { return }
        
        var index = playlist.firstIndex(where: { $0.id == currentTrack.id }) ?? 0
        index += 1
        
        guard index < playlist.count else { return }
        
        let nextTrack = playlist[index]
        let item = playerItem(from: nextTrack)
        
        self.currentTrack = nextTrack
        
        player.replaceCurrentItem(with: item)
        play()
    }
    
    func seek(to position: TimeInterval) {
        player.seek(to: CMTime(seconds: position, preferredTimescale: CMTimeScale(1.0)))
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            self.delegate?.audioPlayer(self, didChangePositionTo: self.player.currentTime().seconds)
        })
    }
    
    // TODO: move to extension
    private func playerItem(from track: Track) -> AVPlayerItem? {
        guard let trackUrl = track.url else { return nil }
        
        return AVPlayerItem(url: trackUrl)
    }
    
    @objc
    private func playerDidFinishPlaying() {
        switchNext()
    }

    private func setupRemoteTransportControls() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .default)
        
            // Make the audio session active.
        
            try audioSession.setActive(true)
        }
        catch {
            print(error)
        }

        commandCenter.togglePlayPauseCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.play()
                return .success
            } else {
                self.pause()
                return .success
            }
        }
        
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.play()
                return .success
            }
            
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in

            if self.player.rate == 1.0 {
                self.pause()
                return .success
            }
            
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            print("next")
            self.switchNext()
            
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            print("prev")
            
            self.switchPrevious()
            
            return .success
        }
    }
    
    func setNowPlayingPlaybackInfo(_ track: Track) {
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = track.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0
        nowPlayingInfo[MPNowPlayingInfoPropertyDefaultPlaybackRate] = 1.0
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
}
