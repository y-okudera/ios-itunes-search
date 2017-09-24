//
//  TrackIconImageTests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/24.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class TrackIconImageTests: XCTestCase {
    
    /// 初期化のテスト
    func testInit() {
        let trackIconImage = TrackIconImage()
        
        XCTAssertEqual(trackIconImage.trackId, 0)
        XCTAssertEqual(trackIconImage.imageData, nil)
    }
    
    /// プライマリキーを確認するテスト
    func testPrimaryKey() {
        XCTAssertEqual(TrackIconImage.primaryKey(), "trackId")
    }
}
