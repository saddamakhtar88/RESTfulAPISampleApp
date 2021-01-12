//
//  NetworkResponseHandlerMock.swift
//  RESTfulAPISampleAppTests
//
//  Created by Saddam Akhtar on 1/12/21.
//

import Foundation
@testable import RESTfulAPISampleApp

struct NetworkResponseHandlerMock: NetworkResponseHandler {
    
    static var decodedData: (decodedInstance: Any?, error: Error?) = (nil, nil)
    static var handledResponse = Result<NetworkError>.success
    
    func handleNetworkResponse(_ response: URLResponse?) -> Result<NetworkError> {
        NetworkResponseHandlerMock.handledResponse
    }
    
    func decodeJsonData<Type>(data: Data?) -> (decodedInstance: Type?,
                                               error: Error?) where Type : Decodable {
        (NetworkResponseHandlerMock.decodedData.decodedInstance as? Type,
         NetworkResponseHandlerMock.decodedData.error)
    }
    
    static func reset() {
        NetworkResponseHandlerMock.decodedData = (nil, nil)
        NetworkResponseHandlerMock.handledResponse = Result<NetworkError>.success
    }
}
