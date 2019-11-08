//
//  NetworkManager.swift
//  HQueue
//
//  Created by Yosia on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    static let QueueAPIKEY = "kweueue"
    private let router = Router<QueueAPI>()

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.faield.rawValue)
        }
    }

    func login(email: String, password: String, completion: @escaping(_ movie: [Movie]?, _ error: String?) -> ()){
        router.request(.login, completion: { data, response, error in
            if error != nil {
                completion(nil, "Please check your connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result =  self .handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse.movies, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated"
    case badRequest = "Not a good request"
    case outdated = "linknya dah expire"
    case faield = "Request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "Cannot decode"
}

enum Result<String> {
    case success
    case failure(String)
}