//
//  TrackUseCase.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import SwiftTask

// MARK: - Interface
protocol TrackUseCase {
    func searchTracks(term: String) -> Task<Float, TrackListEntity, ITunesSearchError>
}

// MARK: - Implementation

/// UseCase どのデータをどのように取得するかここで実装する (UIには直接関与しない)
final class TrackUseCaseImpl: TrackUseCase {

    private let trackRepository: TrackRepository

    init(trackRepository: TrackRepository) {
        self.trackRepository = trackRepository
    }

    func searchTracks(term: String) -> Task<Float, TrackListEntity, ITunesSearchError> {
        return trackRepository.searchTracks(term:term)
    }
}
