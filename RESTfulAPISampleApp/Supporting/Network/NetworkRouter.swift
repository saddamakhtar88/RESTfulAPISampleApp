//
//  NetworkRouter.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

public typealias NetworkRequestCompletion = (_ data: Data?,
                                             _ response: URLResponse?,
                                             _ error: Error?) -> Void

protocol NetworkRouter: Cancellable {
    func request(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion)
}

public protocol Endpoint {
    func urlRequest() throws -> URLRequest
}

