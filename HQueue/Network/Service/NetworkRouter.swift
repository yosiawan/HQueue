//
//  File.swift
//  HQueue
//
//  Created by Yosia on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation
import Network

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

