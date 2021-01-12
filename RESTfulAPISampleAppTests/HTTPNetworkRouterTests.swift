//
//  ImageSearchNetworkServiceTests.swift
//  RESTfulAPISampleAppTests
//
//  Created by Saddam Akhtar on 1/11/21.
//

import XCTest
@testable import RESTfulAPISampleApp

class ImageSearchNetworkServiceTests: XCTestCase {

    var imageSearchNetworkService: ImageSearchNetworkService!
    
    override func setUpWithError() throws {
        DI.reset()
        
        DI.register { () -> Environment in Development() }
        DI.register { () -> NetworkRouter in NetworkRouterMock() }
        DI.register { () -> NetworkResponseHandler in NetworkResponseHandlerMock() }
        
        NetworkRouterMock.reset()
        NetworkResponseHandlerMock.reset()
        
        imageSearchNetworkService = ImageSearchNetworkService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetImagesNetworkError() throws {
        NetworkRouterMock.error = NetworkError.failed
        NetworkResponseHandlerMock.handledResponse = .failure(.badRequest)
        
        let expectation = XCTestExpectation(description: "network error")
        _ = imageSearchNetworkService.getImages(for: "test-data") { (result, error) in
            
            XCTAssert(error is NetworkError)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetImagesResponseError() throws {
        NetworkResponseHandlerMock.handledResponse = .failure(.badRequest)
        
        let expectation = XCTestExpectation(description: "response error")
        _ = imageSearchNetworkService.getImages(for: "test-data") { (result, error) in
            
            XCTAssertNil(result)
            XCTAssert(error is NetworkError)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetImagesSuccess() throws {
        NetworkResponseHandlerMock.handledResponse = .success
        NetworkResponseHandlerMock.decodedData = (ImageSearchResultModel(), nil)
        
        let expectation = XCTestExpectation(description: "returns data")
        _ = imageSearchNetworkService.getImages(for: "test-data") { (result, error) in
            
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
