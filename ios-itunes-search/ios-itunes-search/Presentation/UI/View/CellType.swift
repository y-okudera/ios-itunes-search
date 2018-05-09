//
//  CellType.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

enum CellType {
    case track
    case empty

    var identifier: String {
        switch self {
        case .track:
            return TrackTableViewCell.identifier
        case .empty:
            return EmptyTableViewCell.identifier
        }
    }
}
