//
//  DummyResponse.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

final class DummyResponse {
    /// 検索APIのダミーレスポンス
    func searchApiJSONString() -> String {
        let testBundle = Bundle(for: type(of: self))
        let jsonPath = testBundle.path(forResource: "search", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: jsonPath!)
        
        return String(data: fileHandle!.readDataToEndOfFile(), encoding: .utf8)!
    }
}
