//
//  HttpTaskRouter.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

// MARK: - NetworkRouter implementation

public class HTTPNetworkRouter: NetworkRouter {
    
    // MARK: - Private properties
    
    private var _defaultCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
    private var _defaultTimeoutInterval = 60.0 // in seconds
    
    private let _urlSession: URLSession
    private var _urlSessionTask: URLSessionTask?
    
    init(session: URLSession) {
        _urlSession = session
    }
    
    // MARK: - Public functions
    
    public func request(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion) {
        let session = _urlSession
        do {
            let request = try endpoint.urlRequest()
            _urlSessionTask = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        _urlSessionTask?.resume()
    }
    
    public func cancel() {
        _urlSessionTask?.cancel()
    }
}
