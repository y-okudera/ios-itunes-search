//
//  ItunesSearchAPITests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class ItunesSearchAPITests: XCTestCase {
    
    let searchApi = ItunesSearchAPI()
    let loadable = SpyItunesSearchLoadable()
    
    override func setUp() {
        super.setUp()
        searchApi.loadable = loadable
    }
    
    override func tearDown() {
        searchApi.loadable = nil
        super.tearDown()
    }
    
    func testLoadTermIsAAA() {
        let expectation = self.expectation(description: "「AAA」で検索したときのテスト")
        loadable.asyncExpectation = expectation
        
        searchApi.load(term: "AAA")
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsエラー: \(error)")
            }
            
            if let result = self.loadable.result {
                
                switch result {
                case .loaded(let tracks):
                    XCTAssertNotNil(result)
                    XCTAssertTrue(tracks.results.count > 0)
                case .offline:
                    XCTFail("オフライン")
                case .emptyData:
                    XCTFail("データが0件")
                case .error:
                    XCTFail("エラー")
                }
            }
        }
    }
}
