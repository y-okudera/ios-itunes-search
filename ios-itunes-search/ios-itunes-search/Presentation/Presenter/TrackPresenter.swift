//
//  TrackPresenter.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

enum TrackStatus {
    case loading
    case normal
    case empty(message: String)
    case searchFailed(message: String)
    case unreachable(message: String)
}

// MARK: - Interface
protocol TrackPresenter {
    func searchTracks(term: String)
}

// MARK: - Implementation

/// Presenter
/// Viewからイベントを受け取り、必要があればイベントに応じたUseCaseを実行する
/// UseCaseから受け取ったデータをViewへ渡す(Viewがどうなっているか知らない)
final class TrackPresenterImpl: TrackPresenter {
    weak var viewInput: TrackViewInput?
    let useCase: TrackUseCase

    init(useCase: TrackUseCase, viewInput: TrackViewInput) {
        self.useCase = useCase
        self.viewInput = viewInput
    }

    func searchTracks(term: String) {

        viewInput?.changedStatus(status: .loading)

        useCase.searchTracks(term: term)
            .success { tracks in
                self.loadedTracks(tracks: tracks)
                
            }.failure { error in
                Logger.error(message: "searchTracks: failure")
                Logger.error(message: "error: \(error)")
                
                if let iTunesSearchError = error.error {
                    Logger.error(message: "error message: \(iTunesSearchError.message)")
                    self.errorHandling(error: iTunesSearchError)
                } else {
                    let searchFailedMessage = NSLocalizedString("ITUNES_SEARCH_FAILED", comment: "")
                    self.viewInput?.changedStatus(status: .searchFailed(message: searchFailedMessage))
                }
        }
    }

    // MARK: - Private
    private func loadedTracks(tracks: TrackListEntity) {
        DispatchQueue.main.async { [weak self] in
            self?.viewInput?.setTrackListEntity(trackListEntity: tracks)
            self?.viewInput?.changedStatus(status: .normal)
        }
    }

    private func errorHandling(error: ITunesSearchError) {
        DispatchQueue.main.async { [weak self] in
            switch error.kind {
            case .empty:
                self?.viewInput?.changedStatus(status: .empty(message: error.message))
            case .searchFailed:
                self?.viewInput?.changedStatus(status: .searchFailed(message: error.message))
            case .unreachable:
                self?.viewInput?.changedStatus(status: .unreachable(message: error.message))
            }
        }
    }
}
