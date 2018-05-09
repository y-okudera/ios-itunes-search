//
//  TrackIconFetchError.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

struct TrackIconFetchError: Error {

    enum ErrorKind {
        case downloadFailed
        case unreachable
    }

    let kind: ErrorKind
}
