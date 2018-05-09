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

        let task = Task<Float, TrackIconEntity, TrackIconFetchError> { progress, fulfill, reject, configure in

            DispatchQueue.main.async { [weak self] in
                if let icon = self?.findByID(trackId: track.trackId) {
                    fulfill(icon)
                    return
                }
            }

            guard let imageUrl = URL(string: track.artworkUrl100) else { return }

            Alamofire.SessionManager.default.request(imageUrl).response(completionHandler: { response in

                if let error = response.error {
                    Logger.error(message: "Failed to download icon.\n->\(error.localizedDescription)")
                    if error.isOffline || error.isTimeout {
                        reject(TrackIconFetchError(kind: .unreachable))
                        return
                    }
                    reject(TrackIconFetchError(kind: .downloadFailed))
                    return
                }

                guard let data = response.data else {
                    reject(TrackIconFetchError(kind: .downloadFailed))
                    return
                }

                DispatchQueue.main.async { [weak self] in
                    let downloadedIcon = TrackIconEntity()
                    downloadedIcon.trackId = track.trackId
                    downloadedIcon.imageData = data
                    self?.add(entity: downloadedIcon)
                    fulfill(TrackIconEntity(value: downloadedIcon))
                }
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
