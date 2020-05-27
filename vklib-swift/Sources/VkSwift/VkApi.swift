//
//  VkApi.swift
//  
//
//  Created by Artem Shuba on 29/03/2020.
//

import Foundation

private let methodBase = "https://api.vk.com/method"

enum VkRequestError : Error {
    case noData
    case invalidResponse(Error)
}

public class VkApi {
    private let httpService: HttpService
    private let clientId: String
    private let clientSecret: String
    private let apiVersion: String
    private let userAgent: String
    
    public var accessToken: VkAccessToken?
    
    // MARK: - Init
    
    public init(clientId: String, clientSecret: String, apiVersion: String, userAgent: String) {
        self.httpService = .default
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.apiVersion = apiVersion
        self.userAgent = userAgent
    }
    
    // MARK: - Private
    
    private func handle<T>(_ data: Data?) -> Result<T, Error> where T: Decodable {
        
        guard let data = data else {
            return .failure(VkRequestError.noData)
        }
        
//        print("Response: \(String(data: data, encoding: .utf8) ?? "")")
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(T.self, from: data)
            return .success(response)
        } catch {
            print(error)
            
            return .failure(VkRequestError.invalidResponse(error))
        }
    }
    
    private func handleError(_ error: Error) -> Result<Data?, Error> {
        switch error {
        case HttpError.clientError(_, let data):
            guard let data = data else { return .failure(error) }
            
            return handleError(data)
        default:
            break
        }
        
        return .success(nil)
    }
    
    private func handleError(_ data: Data) -> Result<Data?, Error> {
        do
        {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode([String : String].self, from: data)
            
            print(response)
            
            switch response["error"] {
            case "need_validation":
                return .failure(VkApiError.needValidation(response["redirect_uri"] ?? ""))
            default:
                break
            }
            
        } catch {
            print(error)
            
            return .failure(VkRequestError.invalidResponse(error))
        }
        
        return .failure(VkApiError.unknown)
    }
}

// MARK: - Auth

extension VkApi {
    public func login(login: String, password: String, scope: VkScope, deviceId: String) -> Result<VkAccessToken, Error> {
        let parameters = [
            "username": login,
            "password": password,
            "grant_type": "password",
            "scope": String(scope.rawValue),
            "deviceId": deviceId,
            "client_id": clientId,
            "client_secret": clientSecret
        ]
        
        let result: Result<VkAccessToken, Error> = httpService
            .getRequest(url: "https://oauth.vk.com/token", parameters: parameters)
            .responseData()
            .flatMapError { handleError($0) }
            .flatMap { handle($0) }
        
        if case let .success(accessToken) = result {
            self.accessToken = accessToken
        }
        
        return result
    }
    
    public func refreshToken(_ token: String) {

    }
}

// MARK: - Audio

extension VkApi {
    public func fetchAudios() -> Result<VkAudioResponse, Error> {
        let parameters = [
            "access_token" : accessToken?.accessToken ?? "",
            "v": apiVersion
        ]

        let headers = [
            "User-Agent" : userAgent
        ]

        let result: Result<VkResponse<VkAudioResponse>, Error> = httpService.getRequest(
            url: "\(methodBase)/audio.get",
            parameters: parameters,
            headers: headers).responseData().flatMap { handle($0) }
        
        return result.map { $0.response }
    }
    
    public func fetchPopularAudios() -> Result<[VkAudio], Error> {
        let parameters = [
            "access_token" : accessToken?.accessToken ?? "",
            "v": apiVersion
        ]

        let headers = [
            "User-Agent" : userAgent
        ]

        let result: Result<VkResponse<[VkAudio]>, Error> = httpService.getRequest(
            url: "\(methodBase)/audio.getPopular",
            parameters: parameters,
            headers: headers).responseData().flatMap { handle($0) }
        
        return result.map { $0.response }
    }
}
