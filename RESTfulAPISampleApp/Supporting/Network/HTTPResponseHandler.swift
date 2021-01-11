//
//  HTTPResponseHandler.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

protocol NetworkResponseHandler {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
    func decodeJsonData<Type: Decodable>(data: Data?) -> (decodedInstance: Type?, message: String?)
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct HTTPResponseHandler: NetworkResponseHandler {
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func decodeJsonData<Type: Decodable>(data: Data?) -> (decodedInstance: Type?, message: String?) {
        guard let responseData = data else {
            return (nil, NetworkResponse.noData.rawValue)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(Type.self, from: responseData)
            return (decodedResponse, nil)
        }
        catch {
            return (nil, NetworkResponse.unableToDecode.rawValue)
        }
    }
}
