//
//  PlayerView.swift
//  Meridian
//
//  Created by Artem Shuba on 06/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit
import VkSwift
import SDWebImage

class PlayerView : UIView {
    @IBOutlet private weak var coverView: UIView!
    @IBOutlet private weak var coverImageView: UIImageView!
    
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    @IBOutlet private weak var positionSlider: UISlider!
    
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
        coverImageView.sd_imageTransition = .fade
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
    
    @IBAction private func positionSliderValueChanged(_ sender: Any) {
        player?.seek(to: TimeInterval(positionSlider.value))
    }
}

extension PlayerView : AudioPlayerDelegate {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeState isPlaying: Bool) {
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeCurrentTrack track: Track?) {
        titleLabel.text = track?.title
        artistLabel.text = track?.artist
        positionLabel.text = "0:00"
        durationLabel.text = track?.duration.durationString
        
        positionSlider.value = 0
        positionSlider.maximumValue = Float(track?.duration ?? 0)
        
        coverImageView.sd_setImage(with: track?.coverUrl)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangePositionTo position: TimeInterval) {
        positionLabel.text = position.durationString
        positionSlider.value = Float(position)
    }
}
