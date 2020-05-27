//
//  LoginRouter.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class LoginRouter : Router {
    weak var sourceViewController: UIViewController?
    
    func routeToMain() {
        let mainViewController = MainViewBuilder.build(withContext: .default)

        setRootViewController(mainViewController)
    }
    
    func routeToValidation(url: URL, delegate: OAuthWebViewControllerDelegate) {
        let oauthWebViewController = OAuthWebViewController()
        oauthWebViewController.delegate = delegate
        oauthWebViewController.load(url: url)

        sourceViewController?.present(oauthWebViewController, animated: true, completion: nil)
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.switchRootViewController(to: viewController, animated: true)
    }
}
