//
//  VkLoginService.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class VkLoginService {
    private let vk: VkApi
    
    init(vk: VkApi) {
        self.vk = vk
    }
    
    func login(login: String, password: String, completion: @escaping (Result<VkAccessToken, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let result = self.vk.login(login: login, password: password, scope: .canAccessAudios, deviceId: "")
            completion(result)
        }
    }
    
    func setToken(_ token: VkAccessToken) {
        vk.accessToken = token
    }
}
