//
//  HttpRequest.swift
//  
//
//  Created by Artem Shuba on 29/03/2020.
//

import Foundation

enum HttpError : Error {
    case clientError(statusCode: Int, data: Data?)
}

/// Represents HTTP request.
struct HttpRequest {
    private let request: URLRequest
    
    /// Initializes HttpRequest with provided URLRequest.
    init(request: URLRequest) {
        self.request = request
    }
    
    /// Performs a request and returns response as Data.
    ///
    /// - Parameter completion: A closure to handle a response.
    func responseData() -> Result<Data?, Error> {
        perform(request)
    }

    private func perform(_ request: URLRequest) -> Result<Data?, Error> {
        print("Request: \(request.url?.absoluteString ?? "")")
        
        var result: Result<Data?, Error>!
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                result = .failure(error)
                semaphore.signal()
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 400..<600:
                    result = .failure(HttpError.clientError(statusCode: httpResponse.statusCode, data: data))
                    semaphore.signal()
                    return
                default:
                    break
                }
            }
            
            result = .success(data)
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        return result
    }
}
