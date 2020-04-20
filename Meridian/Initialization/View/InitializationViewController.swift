//
//  InitializationViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class InitializationViewController : UIViewController {
    private let presenter: InitializationPresenter
    
    init?(coder: NSCoder, presenter: InitializationPresenter) {
        self.presenter = presenter
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
    }
}
