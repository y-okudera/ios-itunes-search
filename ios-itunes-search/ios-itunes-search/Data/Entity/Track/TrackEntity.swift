//
//  TrackEntity.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

/// Entity DataStoreで扱うことができるデータの静的なモデル
struct TrackListEntity: Codable {
    var resultCount = 0
    var results = [TrackEntity]()
}

struct TrackEntity: Codable {
    var trackId = 0
    var trackName = ""
    var artistName = ""
    var artworkUrl100 = ""
}
