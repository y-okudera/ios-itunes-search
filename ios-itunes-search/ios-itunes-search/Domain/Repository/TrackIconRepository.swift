//
//  TrackIconRepository.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import SwiftTask

// MARK: - Interface
protocol TrackIconRepository {
    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconEntity, TrackIconFetchError>
}

// MARK: - Implementation
final class TrackIconRepositoryImpl: TrackIconRepository {

    private let dataStore: TrackIconDataStore

    init(dataStore: TrackIconDataStore) {
        self.dataStore = dataStore
    }

    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconEntity, TrackIconFetchError> {
        return dataStore.fetchTrackIcon(track: track)
    }
}
