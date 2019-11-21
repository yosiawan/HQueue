//
//  File.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct HostpitalResponse {
    let current_page: Int
    let total: Int
    let last_page: Int
    let data: [Hospital]
}

extension HostpitalResponse: Decodable {
    private enum HospitalResponseCodingKeys: String, CodingKey {
        case current_page = "current_page"
        case total = "total"
        case last_page = "last_page"
        case data = "data"
    }
    
    init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HospitalResponseCodingKeys.self)
        current_page = try container.decode(Int.self, forKey: .current_page)
        total = try container.decode(Int.self, forKey: .total)
        last_page = try container.decode(Int.self, forKey: .last_page)
        data = try container.decode([Hospital].self, forKey: .data)
    }
}

struct Hospital {
    var id: Int
    var name: String
    var address: String
    var photo: String?
}

extension Hospital: Decodable {
    enum HospitalCodingKeys: String, CodingKey {
        case id = "id"
        case name = "full_name"
        case address = "address"
        case photo = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HospitalCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        photo = try container.decode(String.self, forKey: .photo)
    }
}
