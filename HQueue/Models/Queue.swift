//
//  Queue.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

enum QueueStatus: Int, Decodable {
    case waiting = 0
    case checkIn = 1
    case checkOut = 2
    case skipped = 3
    case terminate = 4
}

struct QueueResponse {
    let success: Bool
    let message: String
    let data: QueueEntity?
}

extension QueueResponse: Decodable {
    enum QueueResponseCodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueResponseCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        message = try container.decode(String.self, forKey: .message)
        data = try? container.decode(QueueEntity.self, forKey: .data)
    }
}

struct QueueEntity {
    let queueId: String
    let submitTime: Date
    var queueRemaining: Int
    let processStatus: QueueStatus
    let poliName: String?
    let patient: Patient
    let insurance: Asuransi?
    let hospital: Hospital
    let doctorSchedule: DoctorScedule
    let doctor: Doctor
}

extension QueueEntity: Decodable {
    enum QueueEntityCodingKeys: String, CodingKey {
        case queue_id = "queue_id"
        case user_id = "user_id"
        case patient_id = "patient_id"
        case doctor_schedule_id = "doctor_schedule_id"
        case is_valid = "is_valid"
        case submit_time = "submit_time"
        case insurance_id = "insurance_id"
        case process_status = "process_status"
        case day = "day"
        case id = "id"
        case doctor_id = "doctor_id"
        case time_start = "time_start"
        case time_end = "time_end"
        case full_name = "full_name"
        case phone_number = "phone_number"
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
        case photo = "photo"
        case province_id = "province_id"
        case city_id = "city_id"
        case hospital_id = "hospital_id"
        case mother_name = "mother_name"
        case identity_number = "identity_number"
        case dob = "dob"
        case gender = "gender"
        case blood_type = "blood_type"
        case auth_id = "auth_id"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case patient_fullname = "patient_fullname"
        case hospital_fullname = "hospital_fullname"
        case insurance_fullname = "insurance_fullname"
        case doctor_fullname = "doctor_fullname"
        case poli_fullname = "poli_fullname"
        case queue_remaining = "queue_remaining"
        case doctor_avatar = "doctor_avatar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueEntityCodingKeys.self)
        let submitTimeIsoString = try container.decode(String.self, forKey: .submit_time)
        
        queueId = try container.decode(String.self, forKey: .queue_id)
        processStatus = try container.decode(QueueStatus.self, forKey: .process_status)
        submitTime = QueueEntity.getSubmiteTimeInDateFormat(isoString: submitTimeIsoString)!
        if let reamingNumber = try? container.decode(Int.self, forKey: .queue_remaining) {
            queueRemaining = reamingNumber
        }else{
            queueRemaining = 0
        }
        poliName = try container.decode(String?.self, forKey: .poli_fullname)
        
        
        patient = Patient(
            fullName: try container.decode(String.self, forKey: .patient_fullname),
            motherName: try container.decode(String.self, forKey: .mother_name),
            identityNumber: try container.decode(String.self, forKey: .identity_number),
            dob: try container.decode(String.self, forKey: .dob),
            gender: try container.decode(Bool.self, forKey: .gender),
            bloodType: try container.decode(String.self, forKey: .blood_type),
            address: nil,
            id: nil)
        
        hospital = Hospital(
            id:  try container.decode(String.self, forKey: .hospital_id),
            name:  try container.decode(String.self, forKey: .hospital_fullname),
            address:  try container.decode(String.self, forKey: .address),
            photo: try container.decode(String.self, forKey: .photo),
            phoneNumber: try container.decode(String.self, forKey: .phone_number),
            latitude: try container.decode(String.self, forKey: .latitude),
            longitude:  try container.decode(String.self, forKey: .longitude)
        )
        
        doctorSchedule = DoctorScedule(
            day: try container.decode(String.self, forKey: .day),
            timeStart: try container.decode(String.self, forKey: .time_start),
            timeEnd: try container.decode(String.self, forKey: .time_end),
            id: try container.decode(String.self, forKey: .doctor_schedule_id),
            doctorId: try container.decode(String.self, forKey: .doctor_id),
            isAvailable: false, queueRemaining: try container.decode(Int.self, forKey: .queue_remaining)
        )
        
        doctor = Doctor(
            name: try container.decode(String.self, forKey: .doctor_fullname),
            schedule: [],
            avatar: try container.decode(String.self, forKey: .doctor_avatar)
            
        )
        
        if let insuranceId = try container.decode(String?.self, forKey: .insurance_id), let insuranceName = try container.decode(String?.self, forKey: .insurance_fullname) {
            insurance = Asuransi(
                name: insuranceName,
                id: insuranceId)
        }else{
            insurance = nil
        }
    }
    
    static func getSubmiteTimeInDateFormat(isoString: String) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        if let date = dateFormater.date(from: isoString) {
            return date
        }
        return nil
    }
}

struct QueueEstimationResponse {
    let success: Bool
    let message: String
    let data: QueueEstimation?
}

extension QueueEstimationResponse: Decodable {
    enum QueueEstimationResponseCodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueEstimationResponseCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode(QueueEstimation?.self, forKey: .data)
    }
}

struct QueueEstimation {
    let estimation: Int
    let time: Date
    let queueRemaining: Int
}

extension QueueEstimation: Decodable {
    enum QueueEstimationCodingKeys: String, CodingKey {
        case estimation = "estimation"
        case time = "time"
        case queue_remaining = "queue_remaining"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueEstimationCodingKeys.self)
        estimation = try container.decode(Int.self, forKey: .estimation)
        
        let timeString = try container.decode(String.self, forKey: .time)
        time = QueueEstimation.getSubmiteTimeInDateFormat(isoString: timeString)!
        
        queueRemaining = try container.decode(Int.self, forKey: .queue_remaining)
    }
    
    func getCurrentEstimate(openTimeSchedule: String) -> String? {
        print(#function + "-openTimeScheduleString", openTimeSchedule)
        let open = Date()
        open.changeFromString(dateString: openTimeSchedule, format: "HH:mm:ss")
        print(#function + "-openTimeSchedule", open)
        
        var currentEstimateTime = Date()
        print(#function + "-estimateTime", time)
        currentEstimateTime = time.addingTimeInterval( TimeInterval(estimation * queueRemaining) )
        print(#function + "-currentEstimateTime", currentEstimateTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        return currentEstimateTime.changeToString(format: "H:mm")
    }
    
    static func getSubmiteTimeInDateFormat(isoString: String) -> Date? {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ssZZ"
        if let date = dateFormater.date(from: isoString) {
            return date
        }
        return Date()
    }
}

enum StatusQueue: Int {
    case waiting = 0
    case checkIn = 1
    case checkOut = 2
    case skipped = 3
}
