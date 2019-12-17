//  Created by Faridho Luedfi on 20/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public enum Queue {
    case registerQueue(patientId: String, doctorScheduleId: String, insuranceId: String?)
    case getQueue
    case getCurrentQueue
    case getEstimationTime
}

extension Queue: EndPointType {
    
    var path: String {
        switch self {
        case .registerQueue:
            return "/queue"
        case .getQueue:
            return "/queue/index"
        case .getCurrentQueue:
            return "/queue/current"
        case .getEstimationTime:
            return "/queue/estimation"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .registerQueue:
            return .post
        case .getQueue, .getCurrentQueue, .getEstimationTime:
            return .get
        }
    }
    
    var task: HTTPTask {
        let bearerToken = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: UserEnv.authToken.rawValue) ?? "")"]
        
        switch self {
        case .registerQueue(let patientId, let doctorScheduleId, let insuranceId?):
            return .requestParametersAndHeaders(
                bodyParameters: [
                    "patient_id": patientId,
                    "doctor_schedule_id": doctorScheduleId,
                    "insurance_id": insuranceId,
                ],
                urlParameters: nil,
                additionalHeaders: bearerToken
            )
            
        case .registerQueue(let patientId, let doctorScheduleId, .none):
            return .requestParametersAndHeaders(
                   bodyParameters: [
                       "patient_id": patientId,
                       "doctor_schedule_id": doctorScheduleId,
                   ],
                   urlParameters: nil,
                   additionalHeaders: bearerToken
            )
            
        case .getQueue, .getCurrentQueue, .getEstimationTime:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: bearerToken)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
