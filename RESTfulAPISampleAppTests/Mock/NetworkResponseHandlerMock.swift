//
//  NetworkResponseHandlerMock.swift
//  RESTfulAPISampleAppTests
//
//  Created by Saddam Akhtar on 1/12/21.
//

import Foundation
@testable import RESTfulAPISampleApp

struct NetworkResponseHandlerMock: NetworkResponseHandler {
    
    var decodedData: (decodedInstance: Any?, error: Error?) = (nil, nil)
    var handledResponse = Result<NetworkError>.success
    
    init(handledResponse: Result<NetworkError> = Result<NetworkError>.success,
         decodedData: (decodedInstance: Any?, error: Error?) = (nil, nil)) {
        self.decodedData = decodedData
        self.handledResponse = handledResponse
    }
    
    func handleNetworkResponse(_ response: URLResponse?) -> Result<NetworkError> {
        handledResponse
    }
    
    func decodeJsonData<Type>(data: Data?) -> (decodedInstance: Type?,
                                               error: Error?) where Type : Decodable {
        (decodedData.decodedInstance as? Type,
         decodedData.error)
    }
}
