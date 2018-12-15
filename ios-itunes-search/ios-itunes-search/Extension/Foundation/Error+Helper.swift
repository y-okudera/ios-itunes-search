//
//  Error+Helper.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

extension Error {
    
    /// ドメイン
    var domain: String {
        return (self as NSError).domain
    }
    
    /// コード
    var code: Int {
        return (self as NSError).code
    }
    
    /// タイムアウトかどうか
    var isTimeout: Bool {
        return domain == NSURLErrorDomain && code == NSURLErrorTimedOut
    }
    
    /// オフラインかどうか
    var isOffline: Bool {
        return domain == NSURLErrorDomain && code == NSURLErrorNotConnectedToInternet
    }
}
