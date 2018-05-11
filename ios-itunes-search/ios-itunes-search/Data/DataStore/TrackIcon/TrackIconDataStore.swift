//
//  TrackIconDataStore.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Alamofire
import Nuke
import SwiftTask
import UIKit

// MARK: - Interface
protocol TrackIconDataStore {
    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconEntity, TrackIconFetchError>
}

// MARK: - Implementation
final class TrackIconDataStoreImpl: TrackIconDataStore {

    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconEntity, TrackIconFetchError> {

        let task = Task<Float, TrackIconEntity, TrackIconFetchError> { [weak self] progress, fulfill, reject, configure in

            if let icon = self?.findByID(trackId: track.trackId) {
                Logger.debug(message: "DBから画像を読み込む")
                fulfill(icon)
                return
            }
            guard let imageUrl = URL(string: track.artworkUrl100) else { return }

            Logger.debug(message: "画像をダウンロードする")
            ImagePipeline.shared.loadImage(with: imageUrl, completion: { imageResponse, error in

                if let error = error {
                    Logger.error(message: "Failed to download icon.\n->\(error.localizedDescription)")
                    if error.isOffline || error.isTimeout {
                        reject(TrackIconFetchError(kind: .unreachable))
                        return
                    }
                    reject(TrackIconFetchError(kind: .downloadFailed))
                    return
                }

                guard let image = imageResponse?.image else {
                    reject(TrackIconFetchError(kind: .downloadFailed))
                    return
                }

                let downloadedIcon = TrackIconEntity()
                downloadedIcon.trackId = track.trackId
                downloadedIcon.imageData = UIImagePNGRepresentation(image)
                self?.add(entity: downloadedIcon)
                fulfill(TrackIconEntity(value: downloadedIcon))
            })
        }
        return task
    }

    // MARK: - Private
    
    private let dao = RealmDaoHelper<TrackIconEntity>()

    /// アイコン画像を取得する
    ///
    /// - Parameter trackId: トラックID
    /// - Returns: アイコン画像の情報
    private func findByID(trackId: Int) -> TrackIconEntity? {
        guard let object = dao.findFirst(key: trackId as AnyObject) else { return nil }
        return TrackIconEntity(value: object)
    }

    /// アイコン画像を登録する
    ///
    /// - Parameter entity: アイコン画像の情報
    private func add(entity: TrackIconEntity) {

        // 登録済みであればreturn
        if let _ = findByID(trackId: entity.trackId) { return }

        let newObject = TrackIconEntity()
        newObject.trackId = entity.trackId
        newObject.imageData = entity.imageData
        dao.add(d: newObject)
    }
}
