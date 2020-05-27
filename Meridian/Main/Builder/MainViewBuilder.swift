//
//  MainViewBuilder.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class MainViewBuilder {
    static func build(withContext appContext: ApplicationContext) -> MainSplitViewController {
        let storyboard = Storyboard.main
        let presenter = MainPresenter()
        let router = MainMenuRouter()
        let menuPresenter = MainMenuPresenter(router: router)
        
        let viewController = MainSplitViewController(presenter: presenter)
        
        let menuViewController = storyboard.instantiateViewController(identifier: String(describing: MainMenuViewController.self), creator: { coder in
            MainMenuViewController(coder: coder, presenter: menuPresenter, player: appContext.audioPlayer)
        })
        
        router.sourceViewController = viewController
        viewController.viewControllers = [menuViewController]

        return viewController
    }
}
