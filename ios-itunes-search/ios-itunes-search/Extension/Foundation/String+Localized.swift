//
//  String+Localized.swift
//  ios-itunes-search
//
//  Created by YukiOkudera on 2018/12/16.
//  Copyright © 2018 YukiOkudera. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
