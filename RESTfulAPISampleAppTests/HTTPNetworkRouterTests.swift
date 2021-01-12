//
//  ImageSearchNetworkServiceTests.swift
//  RESTfulAPISampleAppTests
//
//  Created by Saddam Akhtar on 1/11/21.
//

import XCTest
@testable import RESTfulAPISampleApp

class ImageSearchNetworkServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        DI.register { () -> Environment in Development() }
    }

    override func tearDownWithError() throws {
        DI.reset()
    }

    func testGetImagesNetworkError() throws {
        // Scenario setup
        DI.register { () -> NetworkRouter in NetworkRouterMock(error: NetworkError.failed) }
        DI.register { () -> NetworkResponseHandler in NetworkResponseHandlerMock() }
        
        // Execution and assertion
        let expectation = XCTestExpectation(description: "network error")
        _ = ImageSearchNetworkService().getImages(for: "test-data") { (result, error) in
            XCTAssert(error is NetworkError, "Expected error of type NetworkError")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetImagesResponseError() throws {
        // Scenario setup
        DI.register { () -> NetworkRouter in NetworkRouterMock() }
        DI.register { () -> NetworkResponseHandler in
            NetworkResponseHandlerMock(handledResponse: .failure(.badRequest))
        }
        
        // Execution and assertion
        let expectation = XCTestExpectation(description: "response error")
        _ = ImageSearchNetworkService().getImages(for: "test-data") { (result, error) in
            XCTAssertNil(result)
            XCTAssert(error is NetworkError, "Expected error of type NetworkError")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetImagesResponseDecodeError() throws {
        // Scenario setup
        DI.register { () -> NetworkRouter in NetworkRouterMock() }
        DI.register { () -> NetworkResponseHandler in
            NetworkResponseHandlerMock(handledResponse: .success,
                                       decodedData: (nil, NetworkError.unableToDecode))
        }
        
        // Execution and assertion
        let expectation = XCTestExpectation(description: "decoding error")
        _ = ImageSearchNetworkService().getImages(for: "test-data") { (result, error) in
            XCTAssertNil(result)
            XCTAssert(error is NetworkError, "Expected error of type NetworkError")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetImagesSuccess() throws {
        // Scenario setup
        DI.register { () -> NetworkRouter in NetworkRouterMock() }
        DI.register { () -> NetworkResponseHandler in
            NetworkResponseHandlerMock(handledResponse: .success,
                                       decodedData: (ImageSearchResultModel(), nil))
        }
        
        // Execution and assertion
        let expectation = XCTestExpectation(description: "returns data")
        _ = ImageSearchNetworkService().getImages(for: "test-data") { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
