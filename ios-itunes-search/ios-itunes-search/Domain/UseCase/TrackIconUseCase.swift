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
    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconModel, TrackIconFetchError>
}

// MARK: - Implementation
final class TrackIconUseCaseImpl: TrackIconUseCase {

    private let trackIconRepository: TrackIconRepository

    init(trackIconRepository: TrackIconRepository) {
        self.trackIconRepository = trackIconRepository
    }

    func fetchTrackIcon(track: TrackEntity) -> Task<Float, TrackIconModel, TrackIconFetchError> {

        let task = Task<Float, TrackIconModel, TrackIconFetchError> { [weak self] progress, fulfill, reject, configure in
            
            self?.trackIconRepository.fetchTrackIcon(track: track)
                .success { trackIconEntity in
                    let translator = TrackIconTranslator()
                    let trackIconModel = translator.translate(trackIconEntity)
                    fulfill(trackIconModel)
                    
                }.failure { error in
                    Logger.error(message: "trackIconRepository.fetchTrackIcon error: \(error)")
                    if let trackIconFetchError = error.error {
                        reject(trackIconFetchError)
                    } else {
                        reject(TrackIconFetchError(kind: .downloadFailed))
                    }
            }
        }
        return task
    }
}
