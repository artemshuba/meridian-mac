//
//  MyMusicViewBuilder.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class MyMusicViewBuilder {
    static func build(withContext appContext: ApplicationContext) -> UIViewController {
        let storyboard = Storyboard.myMusic
        let presenter = MyMusicPresenter(vkMusicService: appContext.vkMusicService, audioPlayer: appContext.audioPlayer)
        
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            MyMusicViewController(coder: coder, presenter: presenter)
        }) else {
            fatalError("Unable to initialize initial view controller")
        }
        
        presenter.view = viewController

        return viewController
    }
}
