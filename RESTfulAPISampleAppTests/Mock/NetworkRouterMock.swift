//
//  MockNetworkRouter.swift
//  RESTfulAPISampleAppTests
//
//  Created by Saddam Akhtar on 1/12/21.
//

import Foundation
@testable import RESTfulAPISampleApp

class NetworkRouterMock: NetworkRouter {
    
    static var data: Data?
    static var response: URLResponse?
    static var error: Error?
    
    static var isCancelled = false
    
    func request(endpoint: HTTPEndpoint, completion: @escaping NetworkRequestCompletion) {
        NetworkRouterMock.isCancelled = false
        completion(NetworkRouterMock.data, NetworkRouterMock.response, NetworkRouterMock.error)
    }
    
    func cancel() {
        NetworkRouterMock.isCancelled = true
    }
    
    static func reset() {
        NetworkRouterMock.isCancelled = false
        NetworkRouterMock.data = nil
        NetworkRouterMock.response = nil
        NetworkRouterMock.error = nil
    }
}
