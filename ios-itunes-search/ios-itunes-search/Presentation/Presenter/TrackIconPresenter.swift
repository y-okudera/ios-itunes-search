//
//  TrackIconPresenter.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

// MARK: - Interface
protocol TrackIconPresenter {
    func fetchTrackIcon(track: TrackEntity)
}

// MARK: - Implementation
final class TrackIconPresenterImpl: TrackIconPresenter {
    weak var viewInput: TrackIconViewInput?
    let useCase: TrackIconUseCase

    init(useCase: TrackIconUseCase, viewInput: TrackIconViewInput) {
        self.useCase = useCase
        self.viewInput = viewInput
    }
    
    func fetchTrackIcon(track: TrackEntity) {

        useCase.fetchTrackIcon(track: track)
            .success { trackIconModel in
                Logger.debug(message: "fetchTrackIcon: success")
                self.loadedTrackIcon(trackIconModel: trackIconModel)

            }.failure { error in
                Logger.debug(message: "fetchTrackIcon: failure")
                Logger.error(message: "error: \(error)")

            }.then { _, _ in
                Logger.debug(message: "fetchTrackIcon: done")
        }
    }

    // MARK: - Private
    private func loadedTrackIcon(trackIconModel: TrackIconModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewInput?.setTrackIconModel(trackIconModel: trackIconModel)
        }
    }
}
