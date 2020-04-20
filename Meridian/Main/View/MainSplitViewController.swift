//
//  MainSplitViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

private let menuWidth: CGFloat = 260

class MainSplitViewController : UISplitViewController {
    private let presenter: MainPresenter
    
    init?(coder: NSCoder, presenter: MainPresenter) {
        self.presenter = presenter
        
        super.init(coder: coder)
    }
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        primaryBackgroundStyle = .sidebar
        minimumPrimaryColumnWidth = menuWidth
        maximumPrimaryColumnWidth = menuWidth
        
        view.backgroundColor = .systemBackground
    }
}
