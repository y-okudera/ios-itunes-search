//
//  TrackIconUseCase.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import SwiftTask

// MARK: - Interface
protocol TrackIconUseCase {
    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconEntity, TrackIconFetchError>
}

// MARK: - Implementation
final class TrackIconUseCaseImpl: TrackIconUseCase {

    private let trackIconRepository: TrackIconRepository

    init(trackIconRepository: TrackIconRepository) {
        self.trackIconRepository = trackIconRepository
    }

    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconEntity, TrackIconFetchError> {
        return trackIconRepository.fetchTrackIcon(track: track)
    }
}
