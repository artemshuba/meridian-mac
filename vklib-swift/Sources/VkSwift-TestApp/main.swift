import vklib_swift
import Foundation

let vkApi = VkApi(clientId: "2274003",
                  clientSecret: "hHbZxrka2uZ6jB1inYsH",
                  apiVersion: "5.116",
                  userAgent: "VKAndroidApp/5.52-4543 (Android 5.1.1; SDK 22; x86_64; unknown Android SDK built for x86_64; en; 320x240)"
)

let result = login().flatMap { _ in fetchTracks() }

switch result {
case .success(let audioResponse):
    print(audioResponse)
case .failure(let error):
    print(error)
}

func login() -> Result<VkAccessToken, Error> {
    print("Login:")
    let login = readLine() ?? ""

    print("Password:")
    let password = readLine() ?? ""
    
    return vkApi.login(login: login,
                password: password,
                scope: .canAccessAudios,
                deviceId: "")
}

func fetchTracks() -> Result<VkAudioResponse, Error> {
    return vkApi.fetchAudios()
}
