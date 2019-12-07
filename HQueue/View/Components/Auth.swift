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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signin, .postProfile, .signup:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    var task: HTTPTask {
        let bearerToken = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "authToken") ?? "")"]
        switch self {
        case .signin(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .signup(let email, let name, let password, let phoneNumber):
            return .requestParameters(bodyParameters: ["email": email, "name": name, "password": password, "c_password": password, "phone_number": phoneNumber], urlParameters: nil)
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
