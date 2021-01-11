//
//  BaseEndpoint.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

struct EndpointSharedMetadata {
    
    let environment: Environment = DI.resolve()
    
    var baseUrl: URL {
        return URL(string: "\(environment.baseURL)")!
    }
    
    var queryParams: [String: String] {
        ["key": environment.APIKey]
    }
    
    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
    
    var timeoutInterval: TimeInterval {
        10.0
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        .reloadIgnoringLocalAndRemoteCacheData
    }
    
}
