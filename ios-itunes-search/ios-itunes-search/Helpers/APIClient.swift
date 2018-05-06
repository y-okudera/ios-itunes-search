//
//  APIClient.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import Alamofire

enum Result {
    case success(Any)
    case failure(Error)
}

final class APIClient {
    
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isOnline() -> Bool {
        
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
    
    /// API Request
    static func request(router: Router,
                        completionHandler: @escaping (Result) -> () = {_ in}) {
        
        Alamofire.request(router).responseData() { (response) in
            
            let statusCode = response.response?.statusCode
            print("HTTP status code: \(String(describing: statusCode))")
            
            switch response.result {
                
            case .success(let value):
                completionHandler(Result.success(value))
                return
                
            case .failure:
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                    return
                }
            }
        }
    }
}
