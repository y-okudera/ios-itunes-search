//
//  TrackIconTranslator.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/10.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

struct TrackIconTranslator: Translator {
    
    typealias Input = TrackIconEntity
    typealias Output = TrackIconModel
    
    func translate(_ entity: TrackIconEntity) -> TrackIconModel {
        
        guard
            let imageData = entity.imageData,
            let image = UIImage(data: imageData) else {
                return TrackIconModel(trackId: entity.trackId)
        }
        return TrackIconModel(trackId: entity.trackId, trackIcon: image)
    }
}
