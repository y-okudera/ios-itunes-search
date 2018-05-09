//
//  TrackDataStore.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Alamofire
import SwiftTask

// MARK: - Interface
protocol TrackDataStore {
    func searchTracks(term: String) -> Task<Float, TrackListEntity, ITunesSearchError>
}

// MARK: - Implementation

/// DataStore APIやDBからデータを実際に取得、更新するクラス
final class TrackDataStoreImpl: TrackDataStore, Request {

    var term = ""
    var country = "JP"
    var lang = "ja_jp"
    var media = "music"

    typealias ResponseComponent = TrackEntity
    typealias Response = TrackListEntity
    typealias ErrorType = ITunesSearchError

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/search"
    }

    var parameters: [String : Any] {
        return [
            "term": term,
            "country": country,
            "lang": lang,
            "media": media
        ]
    }

    func searchTracks(term: String) -> Task<Float, Response, ITunesSearchError> {

        self.term = term

        func determineAPIErrorType(apiError: APIError) -> ITunesSearchError {

            switch apiError {
            case .connectionError(let error):

                if error.isOffline {
                    Logger.debug(message: "isOffline")
                    return ITunesSearchError(kind: .unreachable)
                }
                if error.isTimeout {
                    Logger.debug(message: "isTimeout")
                    return ITunesSearchError(kind: .unreachable)
                }
                return ITunesSearchError(kind: .searchFailed)

            case .invalidResponse:
                return ITunesSearchError(kind: .searchFailed)

            case .parseError(let responseData):

                Logger.debug(message: "responseData: \(String(data: responseData, encoding: .utf8) ?? "")")
                return ITunesSearchError(kind: .searchFailed)
            }
        }

        let task = Task<Float, Response, ITunesSearchError> { progress, fulfill, reject, configure in

            APIClient.request(request: self)
                .success { result in
                    Logger.debug(message: "APIClient.request: success")

                    if result.resultCount == 0 {
                        reject(ITunesSearchError(kind: .empty))
                        return
                    }
                    fulfill(result)

                }.failure { error in
                    Logger.debug(message: "APIClient.request: failure")
                    Logger.error(message: "error: \(error)")

                    guard let apiError = error.error else {
                        reject(ITunesSearchError(kind: .searchFailed))
                        return
                    }
                    reject(determineAPIErrorType(apiError: apiError))

                }.then { _, _ in
                    Logger.debug(message: "APIClient.request: done")
            }
        }
        return task
    }
}
