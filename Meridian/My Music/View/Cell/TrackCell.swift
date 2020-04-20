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
    
    func configure(with track: VkAudio) {
        titleLabel.text = track.title
        artistLabel.text = track.artist
        durationLabel.text = stringFromTime(interval: track.duration)
    }
    
    func stringFromTime(interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: interval)!
    }

}
