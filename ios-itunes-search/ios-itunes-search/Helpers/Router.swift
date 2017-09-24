//
//  Router.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    /// ベースURL
    static let baseURLString = "https://itunes.apple.com"
    
    /// 検索API
    case searchAPI([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .searchAPI(let params):
                return (.get, "/search", params)
            }
        }()
        
        if let url = URL(string: Router.baseURLString) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            fatalError("url is nil.")
        }
    }
}
