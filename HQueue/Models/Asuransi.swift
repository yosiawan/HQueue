//
//  Asuransi.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct Asuransi {
//    let imgUrl: String?
    let name: String
    let id: String
}

extension Asuransi: Decodable {
    enum AsuransiCodingKeys: String, CodingKey {
//        case imgUrl = "img"
        case name = "full_name"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AsuransiCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
//        imgUrl = try container.decode(String.self, forKey: .imgUrl)
        id = try container.decode(String.self, forKey: .id)
    }
}
