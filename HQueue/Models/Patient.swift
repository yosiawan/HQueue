//
//  Patient.swift
//  HQueue
//
//  Created by Faridho Luedfi on 12/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public struct PatientResponseForm {
    let success: Bool
    let message: String
    var data: Patient
}

extension PatientResponseForm: Decodable {
    enum PatientResponseKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PatientResponseKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode(Patient.self, forKey: .data)
    }
}

public struct Patient {
    var fullName: String
    var motherName: String
    var identityNumber: String?
    var dob: String
    var gender: Bool
    var bloodType: String
    var address: String?
    let id: Int?
    var photoIdentity: String?
    
    public func getGenderString(_ femaleLabel: String = "Perempuan",_ male: String = "Laki - laki" ) -> String {
        return self.gender ? femaleLabel : male
    }
}

extension Patient: Decodable {
    enum PatientCodingKeys: String, CodingKey {
        case fullName = "full_name"
        case motherName = "mother_name"
        case identityNumber = "identity_number"
        case dob = "dob"
        case gender = "gender"
        case bloodType = "blood_type"
        case address = "address"
        case id = "id"
        case photoIDentity = "identity_photo"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PatientCodingKeys.self)
        fullName = try container.decode(String.self, forKey: .fullName)
        motherName = try container.decode(String.self, forKey: .motherName)
        identityNumber = try container.decode(String.self, forKey: .identityNumber)
        dob = try container.decode(String.self, forKey: .dob)
        gender = try container.decode(Bool.self, forKey: .gender)
        bloodType = try container.decode(String.self, forKey: .bloodType)
        address = try? container.decode(String.self, forKey: .address)
        id = try? container.decode(Int.self, forKey: .id)
        photoIdentity = try? container.decode(String.self, forKey: .photoIDentity)
    }
}
