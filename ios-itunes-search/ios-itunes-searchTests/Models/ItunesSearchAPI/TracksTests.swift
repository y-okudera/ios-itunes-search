//
//  TracksTests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import ios_itunes_search

final class TracksTests: XCTestCase {
    
    func testMapping() {
        
        let dummy = DummyResponse().searchApiJSONString()
        
        guard let tracks = Mapper<Tracks>().map(JSONString: dummy) else {
            XCTFail("Mapping failure.")
            return
        }
        
        XCTAssertEqual(tracks.resultCount, 1)
        XCTAssertEqual(tracks.results.first?.trackId, 256412807)
        XCTAssertEqual(tracks.results.first?.trackName, "桜")
        XCTAssertEqual(tracks.results.first?.artistName, "コブクロ")
        XCTAssertEqual(tracks.results.first?.artworkUrl100, "http://is3.mzstatic.com/image/thumb/Music/v4/73/bd/7c/73bd7c40-2e85-d5a9-3549-5a8bbdabfb50/source/100x100bb.jpg")
    }
}
