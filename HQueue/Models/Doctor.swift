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
}

extension Doctor: Decodable {
    enum DoctorCodingKeys: String, CodingKey {
        case name = "full_name"
        case schedule = "schedule"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DoctorCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        schedule = try container.decode([DoctorScedule].self, forKey: .schedule)
    }
}

struct DoctorScedule {
    let day: String
    let time: String
    let id: String
    let doctorId: String
}

extension DoctorScedule: Decodable {
    enum DoctorScheduleCodingKeys: String, CodingKey {
            case day = "day"
            case id = "id"
            case time = "time"
            case doctorId = "doctor_id"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DoctorScheduleCodingKeys.self)
            day = try container.decode(String.self, forKey: .day)
            id = try container.decode(String.self, forKey: .id)
            time = try container.decode(String.self, forKey: .time)
            doctorId = try container.decode(String.self, forKey: .doctorId)
        }
}
