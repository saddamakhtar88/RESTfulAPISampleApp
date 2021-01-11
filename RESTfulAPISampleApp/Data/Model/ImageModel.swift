//
//  ImageModel.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

struct ImageModel: Codable {
    var id: UInt!
    var previewURL: String!
    var largeImageURL: String!
    var likes: UInt = 0
    var comments: UInt = 0
}
