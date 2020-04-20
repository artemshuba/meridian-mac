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
        let menuPresenter = MainMenuPresenter()
        
        let viewController = MainSplitViewController(presenter: presenter)
        
//        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
//            MainSplitViewController(coder: coder, presenter: presenter)
//        }) else {
//            fatalError("Unable to initialize initial view controller")
//        }
//
//
        
        let menuViewController = storyboard.instantiateViewController(identifier: String(describing: MainMenuViewController.self), creator: { coder in
            MainMenuViewController(coder: coder, presenter: menuPresenter, player: appContext.audioPlayer)
        })
        
        viewController.viewControllers = [menuViewController]

        return viewController
    }
}
