//
//  HttpEndpoint.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

public protocol HTTPEndpoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryParams: [String: String] { get }
    var body: Data? { get }
    var timeoutInterval: TimeInterval? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
}

enum HTTPEndpointError: Error {
    case urlError(String)
}
