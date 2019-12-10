//
//  Queue.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct QueueResponse {
    let success: Bool
    let message: String
}

extension QueueResponse: Decodable {
    enum QueueResponseCodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueResponseCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        message = try container.decode(String.self, forKey: .message)
    }
}

struct QueueEntity {
    let isValid: Bool
    let submitTime: Date
    let doctorScheduleId: String
    let patientId: String
    let insuranceId: String?
    let processStatus: Int
    let id: String
}

extension QueueEntity {
    enum QueueEntityCodingKeys: String, CodingKey {
        case isValid = "is_valid"
        case submitTime = "submit_date"
        case doctorScheduleId = "doctor_schedule_id"
        case patientId = "patient_id"
        case insuranceId = "insurance_id"
        case processStatus = "process_status"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueEntityCodingKeys.self)
        isValid = try container.decode(Bool.self, forKey: .isValid)
        submitTime = try container.decode(Date.self, forKey: .submitTime)
        doctorScheduleId = try container.decode(String.self, forKey: .doctorScheduleId)
        patientId = try container.decode(String.self, forKey: .patientId)
        insuranceId = try container.decode(String.self, forKey: .insuranceId)
        processStatus = try container.decode(Int.self, forKey: .processStatus)
        id = try container.decode(String.self, forKey: .id)
    }
}
