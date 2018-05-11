//
//  APIClient.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/08.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Alamofire
import SwiftTask

enum APIError: Error {
    case connectionError(Error)
    case invalidResponse
    case parseError(Data)
}

struct APIClient {

    static func request<T: Request>(request: T) -> Task<Float, T.Response, APIError> {

        let endPoint = request.baseURL.absoluteString + request.path
        let method = request.method
        let parameters = request.parameters
        let headers = request.httpHeaderFields

        let task = Task<Float, T.Response, APIError> { progress, fulfill, reject, configure in

            let request = Alamofire.request(
                endPoint,
                method: method,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers
                )
                .validate(statusCode: 200 ..< 300)
                .responseData(completionHandler: { response in
                    
                    if let error = response.result.error {
                        reject(.connectionError(error))
                        return
                    }
                    
                    guard
                        let responseData = response.result.value,
                        let urlResponse = response.response else {
                            reject(.invalidResponse)
                            return
                    }
                    
                    guard let model = request.responseFromData(data: responseData, urlResponse: urlResponse) else {
                        reject(.parseError(responseData))
                        return
                    }
                    
                    fulfill(model)
                })

            Logger.debug(message: request.debugDescription)
        }
        return task
    }
}
