//
//  Doctor.swift
//  HQueue
//
//  Created by Faridho Luedfi on 27/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct DoctorResponse {
    let current_page: Int
    let total: Int
    let last_page: Int
    let data: [Doctor]
}

extension DoctorResponse: Decodable {
    enum DoctorResponseCodingKeys: String, CodingKey {
        case current_page = "current_page"
        case total = "total"
        case last_page = "last_page"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DoctorResponseCodingKeys.self)
        current_page = try container.decode(Int.self, forKey: .current_page)
        total = try container.decode(Int.self, forKey: .total)
        last_page = try container.decode(Int.self, forKey: .last_page)
        data = try container.decode([Doctor].self, forKey: .data)
    }
}

struct Doctor {
    let name: String
    let schedule: [DoctorScedule]
    let avatar: String
}

extension Doctor: Decodable {
    enum DoctorCodingKeys: String, CodingKey {
        case name = "full_name"
        case schedule = "schedule"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DoctorCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        schedule = try container.decode([DoctorScedule].self, forKey: .schedule)
        avatar = try container.decode(String.self, forKey: .avatar)
    }
}

struct DoctorScedule {
    let day: String
    let timeStart: String
    let timeEnd: String
    let id: String
    let doctorId: String
    let isAvailable: Bool
    var queueRemaining: Int
}

extension DoctorScedule: Decodable {
    enum DoctorScheduleCodingKeys: String, CodingKey {
            case day = "day"
            case id = "id"
            case timeStart = "time_start"
            case timeEnd = "time_end"
            case doctorId = "doctor_id"
            case isAvailable = "is_available"
            case queueRemaining = "queue_remaining"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DoctorScheduleCodingKeys.self)
            day = try container.decode(String.self, forKey: .day)
            id = try container.decode(String.self, forKey: .id)
            timeStart = try container.decode(String.self, forKey: .timeStart)
            timeEnd = try container.decode(String.self, forKey: .timeEnd)
            doctorId = try container.decode(String.self, forKey: .doctorId)
            isAvailable = try container.decode(Bool.self, forKey: .isAvailable)
            queueRemaining = try container.decode(Int.self, forKey: .queueRemaining)
        }
}
