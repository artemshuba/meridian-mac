//
//  PlayerView.swift
//  Meridian
//
//  Created by Artem Shuba on 06/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit
import VkSwift

class PlayerView : UIView {
    
    @IBOutlet private weak var coverView: UIView!
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    @IBOutlet private weak var previousButton: UIButton!
    @IBOutlet private weak var nextButon: UIButton!
    
    weak var player: AudioPlayer? {
        didSet {
            player?.delegate = self
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fromNib()
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fromNib()
        setupViews()
    }
    
    private func setupViews() {
        player?.delegate = self
        
        coverView.layer.cornerRadius = 10
    }
    
    @IBAction private func playPauseButtonClick(_ sender: Any) {
        guard let player = self.player else { return }
        
        player.isPlaying ? player.pause() : player.play()
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        player?.switchPrevious()
    }
    
    @IBAction private func nextButtonClick(_ sender: Any) {
        player?.switchNext()
    }
}

extension PlayerView : AudioPlayerDelegate {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeState isPlaying: Bool) {
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeCurrentTrack track: VkAudio?) {
        titleLabel.text = track?.title
        artistLabel.text = track?.artist
    }
}
