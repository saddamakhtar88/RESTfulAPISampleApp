//
//  ImageSearchResultModel.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

struct ImageSearchResultModel: Codable {
    var total: UInt = 0
    var totalHits: UInt = 0
    var images: [ImageModel] = []
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalHits
        case images = "hits"
    }
}
