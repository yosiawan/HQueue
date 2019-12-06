//
//  PatientEndPoint.swift
//  HQueue
//
//  Created by Faridho Luedfi on 20/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public enum PatientAPI {
   case getPatient
}

extension PatientAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://167.71.203.148/api/v1") else { fatalError("Base URL not configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getPatient:
            return "/patient"
        }
    }
    
    var httpMethod: HTTPMethod {
       switch self {
       case .getPatient:
        return .get
       }
    }
    
    var task: HTTPTask {
        let bearerToken = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "authToken") ?? "")"]
       switch self {
       case .getPatient:
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: bearerToken)
       }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
