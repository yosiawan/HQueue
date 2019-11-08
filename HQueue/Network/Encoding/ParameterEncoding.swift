//
//  ParameterEncoding.swift
//  HQueue
//
//  Created by Yosia on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public typealias Params = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Params) throws
}

public enum NetworkError: String, Error {
    case parametersNil  = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL     = "URL is nil"
}
