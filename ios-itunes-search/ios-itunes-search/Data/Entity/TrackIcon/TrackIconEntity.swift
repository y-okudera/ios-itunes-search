//
//  TrackIconEntity.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation
import RealmSwift

final class TrackIconEntity: Object {
    @objc dynamic var trackId = 0
    @objc dynamic var imageData: Data?

    override static func primaryKey() -> String? {
        return "trackId"
    }
}

