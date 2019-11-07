//
//  HTTPTask.swift
//  HQueue
//
//  Created by Yosia on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(
        bodyParameters: Params?,
        urlParameters: Params?
    )
    case requestParametersAndHeaders(
        bodyParameters: Params?,
        urlParameters: Params?,
        additionalHeaders: HTTPHeaders?
    )
    // add more cases as needed (download, upload)
}
