//
//  HospitalEndPoint.swift
//  HQueue
//
//  Created by Faridho Luedfi on 20/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public enum HospitalAPI {
    case getHospital(search: String?, page: Int)
    case getPoli(hospitalId: String, search: String?, page: Int)
    case getDoctor(search: String? ,poli: Poli, page: Int)
    case getInsurance(hospital_id: String)
}

extension HospitalAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://167.71.203.148/api/v1") else { fatalError("Base URL not configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getHospital(let search?, _):
            return "/hospital/\(search)"
        case .getHospital(.none, _):
            return "/hospital"
        case .getPoli(let hospitalId, let search?, _):
            return "/poli/\(hospitalId)/\(search)"
        case .getPoli(let hospitalId, .none, _):
            return "/poli/\(hospitalId)"
        case .getDoctor(.none ,let poli, _):
            return "/doctor/\(poli.hospitalId)/\(poli.id)"
        case .getDoctor(let search?, let poli, _):
            return "/doctor/\(poli.hospitalId)/\(poli.id)/\(search)"
        case .getInsurance(let hospital_id):
            return "/insurance/\(hospital_id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getHospital, .getPoli, .getDoctor, .getInsurance:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getHospital( _, let page):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "page": page ])
        case .getPoli( _, _, let page):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "page": page ])
        case .getDoctor(_, _, let page):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "page": page ])
        case .getInsurance(_):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
