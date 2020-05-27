//
//  InitializationPresenter.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class InitializationPresenter : Presenter {
    // MARK: - Properties: private
    
    private let appSettings: AppSettings
    private let router: InitializationRouter
    private let vk: VkApi
    
    // MARK: - Init
    
    init(router: InitializationRouter, appSettings: AppSettings, vk: VkApi) {
        self.appSettings = appSettings
        self.router = router
        self.vk = vk
    }
    
    // MARK: - Public
    
    func load() {
        if appSettings.accessToken == nil {
            router.routeToLogin()
        } else {
            vk.accessToken = appSettings.accessToken
            router.routeToMain()
        }
    }
}
