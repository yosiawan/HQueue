//
//  File.swift
//  HQueue
//
//  Created by Yosia on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation
import Network

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
}

public typealias HTTPHeaders = [String: String]
public typealias Params = [String: Any]
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Params) throws
}

public enum NetworkError: String, Error {
    case parametersNil  = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL     = "URL is nil"
}

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Params) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

public struct JSONParamaterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Params) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
