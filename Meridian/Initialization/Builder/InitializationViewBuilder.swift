//
//  InitializationViewBuilder.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class InitializationViewBuilder {
    static func build(withContext appContext: ApplicationContext) -> InitializationViewController {
        let storyboard = Storyboard.initialization
        let router = InitializationRouter()
        let presenter = InitializationPresenter(router: router,
                                                appSettings: appContext.appSettings,
                                                vk: appContext.vk)
        
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            InitializationViewController(coder: coder, presenter: presenter)
        }) else {
            fatalError("Unable to initialize initial view controller")
        }

        return viewController
    }
}
