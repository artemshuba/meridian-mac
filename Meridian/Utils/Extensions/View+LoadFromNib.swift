//
//  View+LoadFromNib.swift
//  Meridian
//
//  Created by Artem Shuba on 06/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

extension UIView {
    /// Loads UIView from Xib
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let nibView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // Xib is not loaded, or its top view is of the wrong type
            return nil
        }
        
        addSubview(nibView)
        nibView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nibView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nibView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nibView.topAnchor.constraint(equalTo: topAnchor),
            nibView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return nibView
    }
}
