//
//  User.swift
//  HQueue
//
//  Created by Faridho Luedfi on 27/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public struct HUser {
    var name: String
    var email: String
    var phoneNumber: String?
    var deviceToken: String?
}

extension HUser: Decodable {
    enum HUserCodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case phoneNumber = "phone_number"
        case deviceToken = "device_token"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HUserCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        deviceToken = try? container.decode(String.self, forKey: .deviceToken)
    }
}
