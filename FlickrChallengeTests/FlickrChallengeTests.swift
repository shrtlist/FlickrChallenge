//
//  FlickrChallengeTests.swift
//  FlickrChallengeTests
//
//  Created by Marco Abundo on 11/20/24.
//

import XCTest
@testable import FlickrChallenge

class FlickrChallengeTests: XCTestCase {

    func testFetchImagesWithValidQuery() {
        let expectation = XCTestExpectation(description: "Fetch images from Flickr")
        let viewModel = FlickrViewModel()

        viewModel.fetchImages(for: "porcupine")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(viewModel.images.isEmpty, "Expected non-empty images for a valid query")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
