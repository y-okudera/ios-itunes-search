//
//  TrackIconImageDao.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import RealmSwift

final class TrackIconImageDao {
    
    static let dao = RealmDaoHelper<TrackIconImage>()
    
    // MARK: - find
    
    /// アイコン画像を取得する
    ///
    /// - Parameter trackId: トラックID
    /// - Returns: アイコン画像の情報
    static func findByID(trackId: Int) -> TrackIconImage? {
        guard let object = dao.findFirst(key: trackId as AnyObject) else { return nil }
        return TrackIconImage(value: object)
    }
    
    // MARK: - add
    
    /// アイコン画像を登録する
    ///
    /// - Parameter model: アイコン画像の情報
    static func add(model: TrackIconImage) {
        
        // 登録済みであればreturn
        if let _ = findByID(trackId: model.trackId) { return }
        
        let newObject = TrackIconImage()
        newObject.trackId = model.trackId
        newObject.imageData = model.imageData
        dao.add(d: newObject)
    }
}
