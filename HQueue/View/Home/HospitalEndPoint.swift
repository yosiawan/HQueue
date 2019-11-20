//
//  HospitalEndPoint.swift
//  HQueue
//
//  Created by Faridho Luedfi on 20/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public enum HospitalAPI {
    case getHospital(search: String, page: Int)
}

extension HospitalAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://167.71.203.148/api/v1") else { fatalError("Base URL not configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getHospital:
            return "/hospital"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getHospital:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getHospital(let search, let page):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "search": search, "page": page ])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
