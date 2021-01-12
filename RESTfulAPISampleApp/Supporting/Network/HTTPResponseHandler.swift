//
//  HTTPResponseHandler.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

protocol NetworkResponseHandler {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<NetworkError>
    func decodeJsonData<Type: Decodable>(data: Data?) -> (decodedInstance: Type?, error: Error?)
}

enum NetworkError:Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

enum Result<NetworkError>{
    case success
    case failure(NetworkError)
}

struct HTTPResponseHandler: NetworkResponseHandler {
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<NetworkError> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkError.authenticationError)
        case 501...599: return .failure(NetworkError.badRequest)
        case 600: return .failure(NetworkError.outdated)
        default: return .failure(NetworkError.failed)
        }
    }
    
    func decodeJsonData<Type: Decodable>(data: Data?) -> (decodedInstance: Type?, error: Error?) {
        guard let responseData = data else {
            return (nil, NetworkError.noData)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(Type.self, from: responseData)
            return (decodedResponse, nil)
        }
        catch {
            return (nil, NetworkError.unableToDecode)
        }
    }
}
