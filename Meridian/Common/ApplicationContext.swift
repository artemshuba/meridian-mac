//
//  ApplicationContext.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import Foundation
import VkSwift

class ApplicationContext {
    private static var vk = VkApi(clientId: "2274003",
                                clientSecret: "hHbZxrka2uZ6jB1inYsH",
                                apiVersion: "5.116",
                                userAgent: "VKAndroidApp/5.52-4543 (Android 5.1.1; SDK 22; x86_64; unknown Android SDK built for x86_64; en; 320x240)")
    
    static let `default` = ApplicationContext(
        appSettings: AppSettings(storage: UserDefaultsStorage(.standard)),
        vk: vk,
        vkLoginService: VkLoginService(vk: vk),
        vkMusicService: VkMusicService(vk: vk),
        audioPlayer: AudioPlayer()
    )
    
    let appSettings: AppSettings
    let vkLoginService: VkLoginService
    let vkMusicService: VkMusicService
    let vk: VkApi
    let audioPlayer: AudioPlayer
    
    init(appSettings: AppSettings, vk: VkApi, vkLoginService: VkLoginService, vkMusicService: VkMusicService, audioPlayer: AudioPlayer) {
        self.appSettings = appSettings
        self.vk = vk
        self.vkLoginService = vkLoginService
        self.vkMusicService = vkMusicService
        self.audioPlayer = audioPlayer
    }
}
