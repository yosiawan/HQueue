//
//  File.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct HostpitalResponse {
    let page: Int
    let total: Int
    let numberOfPage: Int
    let data: [Hospital]
}

extension HostpitalResponse: Decodable {
    private enum HospitalResponseCodingKeys: String, CodingKey {
        case page
        case total = "total"
        case numberOfPage = "last_page"
        case data = "data"
    }
    
    init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HospitalResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        total = try container.decode(Int.self, forKey: .total)
        numberOfPage = try container.decode(Int.self, forKey: .numberOfPage)
        data = try container.decode([Hospital].self, forKey: .data)
    }
}

struct Hospital {
    var id: Int
    var name: String
    var address: String
}

extension Hospital: Decodable {
    enum HospitalCodingKeys: String, CodingKey {
        case id = "id"
        case name = "full_name"
        case address = "address"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HospitalCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
    }
}
