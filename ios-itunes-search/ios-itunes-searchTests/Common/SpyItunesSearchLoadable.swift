//
//  SpyItunesSearchLoadable.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class SpyItunesSearchLoadable: ItunesSearchLoadable {
    
    var result: ItunesSearchAPIStatus?
    var asyncExpectation: XCTestExpectation?
    
    func setResult(result: ItunesSearchAPIStatus) {
        
        guard let expectation = asyncExpectation else {
            XCTFail("Delegateが正しく設定されていない")
            return
        }
        
        self.result = result
        expectation.fulfill()
    }
}
