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
    case updatePatient(patient: Patient)
    case addPatient(patient: Patient)
}

extension PatientAPI: EndPointType {
    
    var path: String {
        switch self {
        case .getPatient:
            return "/patient/index"
        case .updatePatient(let patient):
            return "/patient/update/\(patient.id!)"
        case .addPatient:
            return "/patient/store"
        }
    }
    
    var httpMethod: HTTPMethod {
       switch self {
       case .getPatient:
        return .get
       case .updatePatient, .addPatient:
        return .post
       }
    }
    
    var task: HTTPTask {
        let bearerToken = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: UserEnv.authToken.rawValue) ?? "")"]
       switch self {
       case .getPatient:
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: bearerToken)
       case .updatePatient(let patient), .addPatient(let patient):
        return .requestParametersAndHeaders(bodyParameters: self.fillBody(patient), urlParameters: nil, additionalHeaders: bearerToken)
       }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    private func fillBody(_ patient: Patient) -> [String : Any]? {
        return [
                "full_name"         : patient.fullName,
                "mother_name"       : patient.motherName,
                "identity_number"   : patient.identityNumber ?? "",
                "dob"               : patient.dob,
                "gender"            : patient.gender,
                "blood_type"        : patient.bloodType,
                "address"           : patient.address ?? "",
                //'identity_photo'    => patient.identity_photo // next dev
            ]
    }
}
