//
//  RedditListingsTests.swift
//  RedditListingsTests
//
//  Created by Kyle McGinnis on 3/2/23.
//

import XCTest
@testable import RedditListings


final class RedditListingsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_PostsViewModel_TopicChange_URLIsValied() throws {
        // Given
        var vm = PostsViewModel(pagingSize: 1)
        vm.setTopic(.new)
        var testTopicURL = "https://www.reddit.com/r/all/new.json?limit=1"
        
        // When
        
        // Then
        print(vm.fullURL)
        XCTAssertEqual(vm.fullURL, testTopicURL)
        
        // Given
        vm.setTopic(.hot)
        testTopicURL = "https://www.reddit.com/r/all/\(Endpoints.Topic.hot.rawValue).json?limit=1"
        
        // When
        
        // Then
        print(vm.fullURL)
        XCTAssertEqual(vm.fullURL, testTopicURL)
    }

}
