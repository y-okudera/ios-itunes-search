//
//  ItunesSearchParamsBuilderTests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class ItunesSearchParamsBuilderTests: XCTestCase {
    
    func testCreate() {
        
        let term = "コブクロ"
        let params = ItunesSearchParamsBuilder.create(term: term) as! [String: String]
        
        XCTAssertEqual(params["term"], "コブクロ")
        XCTAssertEqual(params["country"], "JP")
        XCTAssertEqual(params["lang"], "ja_jp")
        XCTAssertEqual(params["media"], "music")
    }
    
}
