//
//  HQAuth.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

/*
struct HQAuthResponse {
    let data: HQAuth
}

extension HQAuthResponse: Decodable {
    enum HQAuthResponseCodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HQAuthResponseCodingKeys.self)
        data = try container.decode(HQAuth.self, forKey: .data)
    }
}
*/

public struct HQAuth {
    let name: String
    let email: String
    let token: String?
    let phoneNumber: String
    let verified: Bool
}

extension HQAuth: Decodable {
    enum HQAuthCodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case token = "token"
        case phoneNumber = "phone_number"
        case verified = "verified"
    }
    
    public init(from decoder: Decoder) throws {
        let hqauthContainer = try decoder.container(keyedBy: HQAuthCodingKeys.self)
        name = try hqauthContainer.decode(String.self, forKey: .name)
        email = try hqauthContainer.decode(String.self, forKey: .email)
        token = try hqauthContainer.decode(String.self, forKey: .token)
        phoneNumber = try hqauthContainer.decode(String.self, forKey: .phoneNumber)
        verified = try hqauthContainer.decode(Bool.self, forKey: .verified)
    }
}
