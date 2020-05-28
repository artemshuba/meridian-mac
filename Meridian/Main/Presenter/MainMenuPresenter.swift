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
    private let menuItems: [MainMenuItem]
    
    init(router: MainMenuRouter) {
        self.router = router
        self.menuItems = MainMenuPresenter.buildMenu()
    }
    
    func load() {
        
    }
    
    func numberOfGroups() -> Int {
        1
    }
    
    func numberOfItems(inGroup group: Int) -> Int {
        menuItems.count
    }
    
    func title(forGroup group: Int) -> String {
        ""
    }
    
    func title(forItemAt indexPath: IndexPath) -> String {
        menuItems[indexPath.row].title
    }
    
    func selectItem(at indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        
        router.routeToMenuItem(menuItem)
    }
    
    private static func buildMenu() -> [MainMenuItem] {
        [
            
            MainMenuItem(type: .myMusic, title: "My music"),
            MainMenuItem(type: .popular, title: "Popular"),
            MainMenuItem(type: .friends, title: "Friends"),
            MainMenuItem(type: .communities, title: "Communities")
        ]
    }
}
