//
//  Tracks.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import ObjectMapper

final class Tracks: Mappable {
    var resultCount = 0
    var results = [Track]()
    
    init?(map: Map){}
    
    func mapping(map: Map) {
        resultCount <- map["resultCount"]
        results     <- map["results"]
    }
}
