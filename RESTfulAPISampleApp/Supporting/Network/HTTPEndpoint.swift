//
//  HttpEndpoint.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

protocol HTTPEndpoint: Endpoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryParams: [String: String] { get }
    var body: Data? { get }
    var timeoutInterval: TimeInterval? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
}

extension HTTPEndpoint {
    
    private var _defaultCachePolicy: URLRequest.CachePolicy {
        URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
    }
    
    private var _defaultTimeoutInterval: TimeInterval {
        60.0 // in seconds
    }
    
    func urlRequest() throws -> URLRequest {
        
        var queryItems = [URLQueryItem]()
        queryParams.forEach { (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        guard var urlComps = URLComponents(string: url.absoluteString) else {
            throw URLError(.badURL)
        }
        
        urlComps.queryItems = queryItems
        
        guard let url = urlComps.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: cachePolicy ?? _defaultCachePolicy,
                                 timeoutInterval: timeoutInterval ?? _defaultTimeoutInterval)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
}
