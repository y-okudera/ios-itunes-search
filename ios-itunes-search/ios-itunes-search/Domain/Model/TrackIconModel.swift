//
//  TrackIconModel.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/10.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

struct TrackIconModel {

    let trackId: Int
    let trackIcon: UIImage

    init(trackId: Int, trackIcon: UIImage = UIImage()) {
        self.trackId = trackId
        self.trackIcon = trackIcon
    }
}
