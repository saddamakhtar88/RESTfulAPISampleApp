//
//  SampleDataService.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import Foundation

protocol ImageSearchService {
    func getImages(for searchKeyword: String,
                   completion: @escaping (_ result: ImageSearchResultModel?,
                                _ error: String?) -> Void) -> Cancellable
}
