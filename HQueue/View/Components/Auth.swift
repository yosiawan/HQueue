//
//  Auth.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public enum HQAuthAPI {
    case signin(email: String, password: String)
    case signup(email: String, name: String, password: String, phoneNumber: String)
    case addDeviceToken(token: String, deviceToken: String)
    case getProfile
}

extension HQAuthAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://167.71.203.148/api/v1") else { fatalError("Base URL not configured") }
//        guard let url = URL(string: "http://locahost:8000/api/v1") else { fatalError("Base URL not configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .signin:
            return "/login"
        case .signup:
            return "/register"
        case .addDeviceToken:
            return "/add-device-token"
        case .getProfile:
            return "/user"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signin, .signup, .addDeviceToken:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .signin(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .signup(let email, let name, let password, let phoneNumber):
            return .requestParameters(bodyParameters: ["email": email, "name": name, "password": password, "c_password": password, "phone_number": phoneNumber], urlParameters: nil)
        case .addDeviceToken(let token, let deviceToken):
            return .requestParametersAndHeaders(bodyParameters: ["device_token": deviceToken], urlParameters: nil, additionalHeaders: ["Authorization" : "Bearer \(token)"])
        case .getProfile:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
