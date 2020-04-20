//
//  Router.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

/// Describes an object responsible for navigation
protocol Router {
    /// Handle prepare method from View Controller
    ///
    /// - Parameter segue: Segue
    /// - Parameter sender: Sender
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension Router {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
