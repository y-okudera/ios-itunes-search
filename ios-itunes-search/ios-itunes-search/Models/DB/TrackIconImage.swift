//
//  TrackIconImage.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import RealmSwift

final class TrackIconImage: Object {
    @objc dynamic var trackId = 0
    @objc dynamic var imageData: Data?
    
    override static func primaryKey() -> String? {
        return "trackId"
    }
}
