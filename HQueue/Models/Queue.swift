//
//  Queue.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct QueueResponse {
    let success: Bool
    let message: String
}

extension QueueResponse: Decodable {
    enum QueueResponseCodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueueResponseCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        message = try container.decode(String.self, forKey: .message)
    }
}

struct CurrentQueue {

}
