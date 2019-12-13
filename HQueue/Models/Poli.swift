//
//  Poli.swift
//  HQueue
//
//  Created by Faridho Luedfi on 17/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct PoliResponse {
    let current_page: Int
    let total: Int
    let last_page: Int
    let data: [Poli]
}

extension PoliResponse: Decodable {
    private enum PoliResponseCodingKeys: String, CodingKey {
        case current_page = "current_page"
        case total = "total"
        case last_page = "last_page"
        case data = "data"
    }
    
    init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PoliResponseCodingKeys.self)
        current_page = try container.decode(Int.self, forKey: .current_page)
        total = try container.decode(Int.self, forKey: .total)
        last_page = try container.decode(Int.self, forKey: .last_page)
        data = try container.decode([Poli].self, forKey: .data)
    }
}

public struct Poli {
    let id: String
    let name: String
    let hospitalId: String
}

extension Poli: Decodable {
    enum PoliCodingKeys: String, CodingKey {
        case id = "id"
        case name = "full_name"
        case hospitalId = "hospital_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PoliCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        hospitalId = try container.decode(String.self, forKey: .hospitalId)
    }
}
