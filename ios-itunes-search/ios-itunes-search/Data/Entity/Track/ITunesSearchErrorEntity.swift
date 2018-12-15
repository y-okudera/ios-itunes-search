//
//  ITunesSearchErrorEntity.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

struct ITunesSearchError: Error {

    enum ErrorKind {
        case empty
        case searchFailed
        case unreachable
    }

    let kind: ErrorKind

    var message: String {
        switch kind {
        case .empty:
            return "ITUNES_SEARCH_FAILED".localized()
        case .searchFailed:
            return "ITUNES_SEARCH_EMPTY".localized()
        case .unreachable:
            return "UNREACHABLE".localized()
        }
    }
}
