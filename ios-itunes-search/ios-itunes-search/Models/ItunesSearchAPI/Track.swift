//
//  ItunesSearchResult.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import ObjectMapper

final class Track: Mappable {
    var trackId = 0
    var trackName = ""
    var artistName = ""
    var artworkUrl100 = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        trackId     <- map["trackId"]
        trackName   <- map["trackName"]
        artistName  <- map["artistName"]
        artworkUrl100 <- map["artworkUrl100"]
    }
}
