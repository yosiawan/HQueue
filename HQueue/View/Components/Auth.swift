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
    case signup(user: HQAuth, password: String)
    case addDeviceToken(token: String, deviceToken: String)
    case getProfile
    case postProfile(user: HUser)
}

extension HQAuthAPI: EndPointType {
    
    var path: String {
        switch self {
        case .signin:
            return "/login"
        case .signup:
            return "/register"
        case .getProfile, .postProfile:
            return "/user"
        case .addDeviceToken:
            return "add-device-token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signin, .signup, .addDeviceToken, .postProfile:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    var task: HTTPTask {
        let bearerToken = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: UserEnv.authToken.rawValue) ?? "")"]
        switch self {
        case .signin(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .signup(let user, let password):
            return .requestParameters(bodyParameters: [
                "email": user.email,
                "name": user.name,
                "password": password,
                "c_password": password,
                "phone_number": user.phoneNumber
            ], urlParameters: nil)
        case .addDeviceToken(let token, let deviceToken):
            return .requestParametersAndHeaders(bodyParameters: ["device_token": deviceToken], urlParameters: nil, additionalHeaders: ["Authorization" : "Bearer \(token)"])
        case .getProfile:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: bearerToken)
        case .postProfile(let user):
            return .requestParametersAndHeaders(
                bodyParameters: [
                    "name": user.name,
                    "email": user.email,
                    "phone_number": user.phoneNumber ?? ""
                ],
                urlParameters: nil,
                additionalHeaders: bearerToken
            )
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
