//
//  MainMenuPresenter.swift
//  Meridian
//
//  Created by Artem Shuba on 07/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class MainMenuPresenter : Presenter {
    private let menuGroups: [MainMenuGroup]
    
    init() {
        self.menuGroups = MainMenuPresenter.buildMenu()
    }
    
    func load() {
        
    }
    
    func numberOfGroups() -> Int {
        menuGroups.count
    }
    
    func numberOfItems(inGroup group: Int) -> Int {
        menuGroups[group].items.count
    }
    
    func title(forGroup group: Int) -> String {
        menuGroups[group].title
    }
    
    func title(forItemAt indexPath: IndexPath) -> String {
        menuGroups[indexPath.section].items[indexPath.row].title
    }
    
    private static func buildMenu() -> [MainMenuGroup] {
        [
            MainMenuGroup(
                title: "My Music",
                items: [
                    MainMenuItem(title: "Songs"),
                    MainMenuItem(title: "News"),
                    MainMenuItem(title: "Wall")
                ]),
            MainMenuGroup(
                title: "Explore",
                items: [
                    MainMenuItem(title: "Popular")
                ]),
            MainMenuGroup(
                title: "People",
                items: [
                    MainMenuItem(title: "Friends"),
                    MainMenuItem(title: "Communities")
                ])
        ]
    }
}
