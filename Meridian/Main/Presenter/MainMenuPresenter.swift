//
//  MainMenuPresenter.swift
//  Meridian
//
//  Created by Artem Shuba on 07/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class MainMenuPresenter : Presenter {
    private let router: MainMenuRouter
    private let menuGroups: [MainMenuGroup]
    
    init(router: MainMenuRouter) {
        self.router = router
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
    
    func selectItem(at indexPath: IndexPath) {
        let menuItem = menuGroups[indexPath.section].items[indexPath.row]
        
        router.routeToMenuItem(menuItem)
    }
    
    private static func buildMenu() -> [MainMenuGroup] {
        [
            MainMenuGroup(
                title: "My Music",
                items: [
                    MainMenuItem(type: .myMusic, title: "Songs"),
                    MainMenuItem(type: .news, title: "News"),
                    MainMenuItem(type: .wall, title: "Wall")
                ]),
            MainMenuGroup(
                title: "Explore",
                items: [
                    MainMenuItem(type: .popular, title: "Popular")
                ]),
            MainMenuGroup(
                title: "People",
                items: [
                    MainMenuItem(type: .friends, title: "Friends"),
                    MainMenuItem(type: .communities, title: "Communities")
                ])
        ]
    }
}
