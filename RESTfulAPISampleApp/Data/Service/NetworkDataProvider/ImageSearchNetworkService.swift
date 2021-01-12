//
//  ImageSearchNetworkService.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation
import DependencyRegistry

// MARK:- ImageSearchService network implementation

struct ImageSearchNetworkService: ImageSearchService {
    
    private var _networkRouter: NetworkRouter {
        DI.resolve(scope: Scope.unique)
    }
    
    @Inject private var _networkResponseHandler: NetworkResponseHandler
    
    func getImages(for searchKeyword: String,
                   completion: @escaping (_ result: ImageSearchResultModel?,
                                          _ error: Error?) -> Void) -> Cancellable {
        let networkRouter = _networkRouter
        let endpoint = ImageSearchEndpoint(sharedMetadata: EndpointSharedMetadata(),
                                           searchKeyword: searchKeyword)
        
        networkRouter.request(endpoint: endpoint) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            }
            
            let responseStatus = _networkResponseHandler.handleNetworkResponse(response)
            switch responseStatus {
            case .success:
                let procecssedResponse: (decodedInstance: ImageSearchResultModel?, error: Error?) = _networkResponseHandler.decodeJsonData(data: data)
                completion(procecssedResponse.decodedInstance, procecssedResponse.error)
            case .failure(let failureMessage):
                completion(nil, failureMessage)
            }
        }
        
        return networkRouter
    }
}

// MARK:- Endpoints

private struct ImageSearchEndpoint: HTTPEndpoint {
    
    let sharedMetadata: EndpointSharedMetadata
    let searchKeyword: String
    
    var url: URL {
        // Configure the url with the required route
        sharedMetadata.baseUrl
    }
    var method: HTTPMethod { .get }
    
    var queryParams: [String: String] {
        let items = ["q": searchKeyword]
        return sharedMetadata.queryParams.merging(items) { (_, new) in new }
    }
    
    var headers: [String : String] { sharedMetadata.headers }
    var timeoutInterval: TimeInterval? { sharedMetadata.timeoutInterval }
    var cachePolicy: URLRequest.CachePolicy? { sharedMetadata.cachePolicy }
    
    var body: Data? { nil }
}
