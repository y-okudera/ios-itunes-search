//
//  ItunesSearchParamsBuilder.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

final class ItunesSearchParamsBuilder {
    
    /// リクエストパラメータを生成する
    ///
    /// - Parameter term: 検索ワード
    /// - Returns: リクエストパラメータ
    static func create(term: String) -> [String: Any] {
        var params = [String: Any]()
        params["term"] = term
        params["country"] = "JP"
        params["lang"] = "ja_jp"
        params["media"] = "music"
        
        return params
    }
}
