//
//  Translator.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/10.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

protocol Translator {
    associatedtype Input
    associatedtype Output
    func translate(_: Input) -> Output
}
