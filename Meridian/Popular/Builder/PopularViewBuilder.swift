//
//  PopularViewBuilder.swift
//  Meridian
//
//  Created by Artem Shuba on 07/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class PopularViewBuilder {
    static func build(withContext appContext: ApplicationContext) -> PopularViewController {
        let storyboard = Storyboard.popular
        let presenter = PopularPresenter(vkMusicService: appContext.vkMusicService, audioPlayer: appContext.audioPlayer)
        
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            PopularViewController(coder: coder, presenter: presenter)
        }) else {
            fatalError("Unable to initialize initial view controller")
        }
        
        presenter.view = viewController

        return viewController
    }
}
