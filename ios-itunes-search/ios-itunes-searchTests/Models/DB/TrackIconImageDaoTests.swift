//
//  TrackIconImageDaoTests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/24.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class TrackIconImageDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UTRealm.removeUTDirectory()
    }
    
    override func tearDown() {
        UTRealm.removeUTDirectory()
        super.tearDown()
    }
    
    /// アイコン画像を登録する処理と取得する処理のテスト
    func testAddAndFind() {
        
        TrackIconImageDao.add(model: dummyModel())
        let addedModel = TrackIconImageDao.findByID(trackId: 256412807)
        
        XCTAssertNotNil(addedModel)
        XCTAssertEqual(addedModel?.trackId, 256412807)
        XCTAssertEqual(addedModel?.imageData, Data())
    }
    
    // MARK: - private methods
    
    /// TrackIconImageのダミー
    private func dummyModel() -> TrackIconImage {
        let model = TrackIconImage()
        model.trackId = 256412807
        model.imageData = Data()
        
        return model
    }
    
}
