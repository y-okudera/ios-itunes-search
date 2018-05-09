//
//  TrackRepository.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import SwiftTask

// MARK: - Interface
protocol TrackRepository {
    func searchTracks(term: String) -> Task<Float, TrackListEntity, ITunesSearchError>
}

// MARK: - Implementation

/// Repository データ取得に必要なDataStoreへデータ処理のリクエストを行う (Domain層とData層のI/F)
final class TrackRepositoryImpl: TrackRepository {

    private let dataStore: TrackDataStore

    init(dataStore: TrackDataStore) {
        self.dataStore = dataStore
    }

    func searchTracks(term: String) -> Task<Float, TrackListEntity, ITunesSearchError> {
        return dataStore.searchTracks(term: term)
    }
}
