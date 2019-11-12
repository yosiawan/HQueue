//
//  HQAuth.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct HQAuth {
    let name: String
    let phoneNumber: String
    let email: String
    let token: String
}

extension HQAuth: Decodable {
    enum HQAuthCodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case token = "token"
        case phoneNumber = "phone_number"
    }
    
    init(from decoder: Decoder) throws {
        let hqauthContainer = try decoder.container(keyedBy: HQAuthCodingKeys.self)
        name = try hqauthContainer.decode(String.self, forKey: .name)
        email = try hqauthContainer.decode(String.self, forKey: .email)
        token = try hqauthContainer.decode(String.self, forKey: .token)
        phoneNumber = try hqauthContainer.decode(String.self, forKey: .phoneNumber)
    }
}
