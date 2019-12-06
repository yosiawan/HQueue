//
//  Patient.swift
//  HQueue
//
//  Created by Faridho Luedfi on 12/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct Patient {
    var fullName: String
    var motherName: String
    var identityNumber: String
    var dob: String
    var gender: Bool
    var address: String
}

extension Patient: Decodable {
    enum PatientCodingKeys: String, CodingKey {
        case fullName = "full_name"
        case motherName = "mother_name"
        case identityNumber = "identity_number"
        case dob = "dob"
        case gender = "gender"
        case address = "address"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PatientCodingKeys.self)
        fullName = try container.decode(String.self, forKey: .fullName)
        motherName = try container.decode(String.self, forKey: .motherName)
        identityNumber = try container.decode(String.self, forKey: .identityNumber)
        dob = try container.decode(String.self, forKey: .dob)
        gender = try container.decode(Bool.self, forKey: .gender)
        address = try container.decode(String.self, forKey: .address)
    }
}
