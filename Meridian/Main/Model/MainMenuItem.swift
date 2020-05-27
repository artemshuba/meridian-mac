//
//  MainMenuItem.swift
//  Meridian
//
//  Created by Artem Shuba on 07/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

enum MainMenuItemType {
    case myMusic
    case news
    case wall
    case popular
    case friends
    case communities
}

struct MainMenuItem {
    let type: MainMenuItemType
    
    let title: String
}
