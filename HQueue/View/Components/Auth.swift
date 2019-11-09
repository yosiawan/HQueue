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
    case signup(email: String, name: String, password: String)
    case getProfile
}

extension HQAuthAPI: EndPointType {
    var baseURL: URL {
        //guard let url = URL(string: "http://167.71.203.148/api/v1") else { fatalError("Base URL not configured") }
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1") else { fatalError("Base URL not configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .signin:
            return "/login"
        case .signup:
            return "/login"
        case .getProfile:
            return "/user"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signin:
            return .post
        case .signup:
            return .post
        case .getProfile:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .signin(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], urlParameters: nil)
        case .signup(let email, let name, let password):
            return .requestParameters(bodyParameters: ["email": email, "name": name, "password": password, "c_password": password], urlParameters: nil)
        case .getProfile:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
