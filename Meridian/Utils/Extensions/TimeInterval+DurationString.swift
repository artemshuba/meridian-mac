//
//  TimeInterval+DurationString.swift
//  Meridian
//
//  Created by Artem Shuba on 27/05/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

extension TimeInterval {
    var durationString: String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        if hours > 0 {
            return String(format: "%d:%0.2d:%0.2d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%0.2d", minutes, seconds)
        }
    }
}
