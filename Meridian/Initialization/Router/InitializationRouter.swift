//
//  InitializationRouter.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class InitializationRouter : Router {
    func routeToLogin() {
        let loginViewController = LoginViewBuilder.build(withContext: .default)
        
        setRootViewController(loginViewController)
    }
    
    func routeToMain() {
        let mainViewController = MainViewBuilder.build(withContext: .default)
        
        setRootViewController(mainViewController)
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.switchRootViewController(to: viewController, animated: false)
    }
}
