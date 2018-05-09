//
//  Error+Helper.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

extension Error {
    
    /// タイムアウトかどうか
    var isTimeout: Bool {
        return (self as NSError).domain == NSURLErrorDomain && (self as NSError).code == NSURLErrorTimedOut
    }

    /// オフラインかどうか
    var isOffline: Bool {
        return (self as NSError).domain == NSURLErrorDomain && (self as NSError).code == NSURLErrorNotConnectedToInternet
    }
}
