//
//  LoginViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private let presenter: LoginPresenter
    
    // MARK: - Init
    
    init?(coder: NSCoder, presenter: LoginPresenter) {
        self.presenter = presenter
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        presenter.load()
    }
    
    // MARK: - Private
    
    @IBAction private func loginEditingChanged(_ sender: Any) {
        presenter.login = loginTextField.text
    }
    
    @IBAction private func passwordEditingChanged(_ sender: Any) {
        presenter.password = passwordTextField.text
    }
    
    @IBAction private func loginClick(_ sender: Any) {
        presenter.performLogin()
    }
}
