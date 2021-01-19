//
//  MockNetworkRouter.swift
//  RESTfulAPISampleAppTests
//
//  Created by Saddam Akhtar on 1/12/21.
//

import Foundation
@testable import RESTfulAPISampleApp

class NetworkRouterMock: NetworkRouter {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var isCancelled = false
    
    init(data: Data? = nil,
         response: URLResponse? = nil,
         error: Error? = nil,
         cancelled: Bool = false) {
        self.data = data
        self.response = response
        self.error = error
        self.isCancelled = cancelled
    }
    
    func request(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion) {
        isCancelled = false
        completion(data, response, error)
    }
    
    func cancel() {
        isCancelled = true
    }
}
