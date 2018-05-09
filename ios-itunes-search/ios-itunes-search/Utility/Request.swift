//
//  Request.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Alamofire
import SwiftTask

protocol Request {

    associatedtype Response
    associatedtype ErrorType

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var httpHeaderFields: [String: String] { get }
    
    func responseFromData(data: Data, urlResponse: HTTPURLResponse) -> Response?
    func errorFromObject(object: Any, urlResponse: HTTPURLResponse) -> Error?
}

extension Request {

    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }

    var httpHeaderFields: [String: String] {
        return [:]
    }

    func errorFromObject(object: Any, urlResponse: HTTPURLResponse) -> Error? {
        return nil
    }
}

extension Request where Response: Codable {

    func responseFromData(data: Data, urlResponse: HTTPURLResponse) -> Response? {

        Logger.debug(message: "\(urlResponse)")

        let model = try? JSONDecoder().decode(Response.self, from: data)
        return model
    }
}
