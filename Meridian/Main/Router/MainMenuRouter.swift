//
//  MainMenuRouter.swift
//  Meridian
//
//  Created by Artem Shuba on 27/05/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class MainMenuRouter : Router {
    weak var sourceViewController: UIViewController?
    
    func routeToMenuItem(_ menuItem: MainMenuItem) {
        var destinationViewController: UIViewController? = nil
        
        switch menuItem.type {
        case .myMusic:
            destinationViewController = MyMusicViewBuilder.build(withContext: .default)
            
        case .popular:
            destinationViewController = PopularViewBuilder.build(withContext: .default)
            
        default:
            break
        }
        
        guard let viewController = destinationViewController else { return }
        
        sourceViewController?.showDetailViewController(viewController, sender: sourceViewController)
    }
}
