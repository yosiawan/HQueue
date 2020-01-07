//
//  ValidationErrorResponse.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/01/20.
//  Copyright © 2020 Apple Dev. Academy. All rights reserved.
//

import Foundation

public struct PatientResponseError {
    let error: [String: [String]]
}

extension PatientResponseError: Decodable {
    enum PatientResponseErrorKeys: String, CodingKey {
        case error = "error"
    }
    
   public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PatientResponseErrorKeys.self)
    error = try container.decode([String: [String]].self, forKey: .error)
    }
    
}
