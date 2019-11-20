//
//  NetworkManager.swift
//  HQueue
//
//  Created by Yosia on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct NetworkManager {
    
//    static let QueueAPIKEY = "kweueue"
    private let router = Router<HQAuthAPI>()

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

    func login(email: String, password: String, completion: @escaping(_ auth: HQAuth?, _ error: String?) -> ()){
        router.request(.signin(email: email, password: password), completion: { data, response, error in
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
                    // print(String(bytes: responseData, encoding: .utf8))
                    do {
                        //print( String(bytes: responseData, encoding: .utf8) )
                        let data = try JSONDecoder().decode(HQAuth.self, from: responseData)
                        completion(data, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
    
    func sigupAndCretePatient(newAuth: HQAuth, newPass: String, patientData: Patient, completion: @escaping(_ auth: HQAuth?, _ error: String?) -> ()) {
        print([newAuth, patientData])
        router.request(.signup(email: newAuth.email, name: newAuth.name, password: newPass, phoneNumber: newAuth.phoneNumber), completion: {data, response, error in
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
                        //print( String(bytes: responseData, encoding: .utf8) )
                        let data = try JSONDecoder().decode(HQAuth.self, from: responseData)
                        completion(data, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        });
    }
    
    func addDeviceToken() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        guard let tokenDevice = UserDefaults.standard.string(forKey: "authTokenDevice") else { return }
        router.request(.addDeviceToken(token: token, deviceToken: tokenDevice)) {
            (data, response, error) in
            //print(#function, token, tokenDevice)
            if error != nil {
                print(#function, error)
            }
            
            if let response = response as? HTTPURLResponse {
                let result =  self.handleNetworkResponse(response)
                print("\(#function) - response", response.statusCode)
                switch result {
                case .success:
                    guard let responseData = data else {
                        //completion(nil, NetworkResponse.noData.rawValue)
                        //print(#function, NetworkResponse.noData.rawValue)
                        return
                    }
                    print(#function, responseData)
                case .failure(let networkFailureError):
                    //completion(nil, networkFailureError)
                    print(#function, networkFailureError)
                }
            
            }
        }
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
