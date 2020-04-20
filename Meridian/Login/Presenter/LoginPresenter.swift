//
//  LoginPresenter.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class LoginPresenter : Presenter {
    private let vkLoginService: VkLoginService
    private let appSettings: AppSettings
    private let router: LoginRouter
    
    var login: String?
    var password: String?
    
    init(vkLoginService: VkLoginService, appSettings: AppSettings, router: LoginRouter) {
        self.vkLoginService = vkLoginService
        self.appSettings = appSettings
        self.router = router
    }
    
    func load() {
        
    }
    
    func performLogin() {
        guard let login = self.login,
            let passwod = self.password else { return }
        
        vkLoginService.login(login: login, password: passwod) { [weak self] result in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                
                switch result {
                case .failure(let error):
                    self.handle(error)
                    
                case .success(let accessToken):
                    self.appSettings.accessToken = accessToken
                    // Save token
                    // Navigate to main
                    print("Login success")
                    self.router.routeToHome()
                }
            }
        }
    }
    
    private func handle(_ error: Error) {
        switch error {
        case VkApiError.needValidation(let redirectUrl):
            guard let url = URL(string: redirectUrl) else { return }
            
            showValidationView(url: url)
        default:
            print("Unknown error \(error)")
            break
        }
    }
    
    private func showValidationView(url: URL) {
        router.routeToValidation(url: url, delegate: self)
    }
}

extension LoginPresenter : OAuthWebViewControllerDelegate {
    func oauth(_ oAuthWebViewController: OAuthWebViewController, didReceive accessToken: String, userId: String) {
        let accessToken = VkAccessToken(accessToken: accessToken, userId: Int(userId) ?? 0)
        
        vkLoginService.setToken(accessToken)
        appSettings.accessToken = accessToken
        router.routeToHome()
    }
}
