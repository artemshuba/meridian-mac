//
//  UIApplication+SwitchRootViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

extension UIApplication {
    func switchRootViewController(to viewController: UIViewController, animated: Bool) {
        guard let window = windows.filter({ $0.isKeyWindow }).first ?? windows.first else { return }

        guard let currentViewController = window.rootViewController,
            animated == false else  {
            window.rootViewController = viewController
            return
        }
        
        UIView.transition(from: currentViewController.view, to: viewController.view, duration: 0.3, options: .transitionCrossDissolve, completion: { _ in
            window.rootViewController = viewController
        })
    }
}
