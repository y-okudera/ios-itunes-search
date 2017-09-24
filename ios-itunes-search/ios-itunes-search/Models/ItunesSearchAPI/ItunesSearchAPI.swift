//
//  ItunesSearchAPI.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import ObjectMapper

/// APIステータス
enum ItunesSearchAPIStatus {
    case loaded(tracks: Tracks)
    case offline
    case emptyData
    case error
}

/// APIリクエスト結果を通知するプロトコル
protocol ItunesSearchLoadable: class {
    func setResult(result: ItunesSearchAPIStatus)
}

final class ItunesSearchAPI {
    
    weak var loadable: ItunesSearchLoadable?
    
    func load(term: String) {
        
        if !APIClient.isOnline() {
            loadable?.setResult(result: .offline)
            return
        }
        
        let parameters = ItunesSearchParamsBuilder.create(term: term)
        
        let router = Router.searchAPI(parameters)
        
        APIClient.request(router: router) { [weak self] result in
            
            switch result {
            case .success(let jsonData):
                guard let tracks = Mapper<Tracks>().map(JSONObject: jsonData),
                    tracks.resultCount != 0 else {
                        self?.loadable?.setResult(result: .emptyData)
                        return
                }
                self?.loadable?.setResult(result: .loaded(tracks: tracks))
                
            case .failure(let error):
                print("error: \(error)")
                self?.loadable?.setResult(result: .error)
            }
        }
    }
}
