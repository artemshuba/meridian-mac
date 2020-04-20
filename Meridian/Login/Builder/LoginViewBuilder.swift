//
//  LoginViewBuilder.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation

class LoginViewBuilder {
    static func build(withContext appContext: ApplicationContext) -> LoginViewController {
        let storyboard = Storyboard.login
        let router = LoginRouter()
        let presenter = LoginPresenter(vkLoginService: appContext.vkLoginService,
                                       appSettings: appContext.appSettings,
                                       router: router)
        
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            LoginViewController(coder: coder, presenter: presenter)
        }) else {
            fatalError("Unable to initialize initial view controller")
        }
        
        router.sourceViewController = viewController

        return viewController
    }
}
