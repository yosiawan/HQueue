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
        let bearerToken = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: UserEnv.authToken.rawValue) ?? "")"]
       switch self {
       case .getPatient:
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: bearerToken)
       }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
