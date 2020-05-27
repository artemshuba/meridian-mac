//
//  TrackCell.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit
import VkSwift

class TrackCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    func configure(with track: Track) {
        titleLabel.text = track.title
        artistLabel.text = track.artist
        durationLabel.text = track.displayDuration
        
        // Fade out content view if track doesn't have url
        contentView.alpha = track.url == nil ? 0.3 : 1.0
    }
}
