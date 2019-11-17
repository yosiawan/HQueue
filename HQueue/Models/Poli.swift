//
//  Poli.swift
//  HQueue
//
//  Created by Faridho Luedfi on 17/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct Poli {
    let id: Int
    let name: String
}

extension Poli: Decodable {
    enum PoliCodingKeys: String, CodingKey {
        case id = "id"
        case name = "full_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PoliCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
