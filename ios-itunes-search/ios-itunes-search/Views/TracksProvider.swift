//
//  TracksProvider.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
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

final class TracksProvider: NSObject {
    private var tracks = [Track]()
    
    func set(tracks: [Track]) {
        self.tracks = tracks
    }
    
    func cellType() -> CellType {
        if tracks.isEmpty {
            return .empty
        }
        return .track
    }
}

// MARK : - UITableViewDataSource
extension TracksProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tracks.isEmpty {
            return 1
        }
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = self.cellType()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier,
                                                 for: indexPath)
        switch (cellType, cell) {
        case (.track, let cell as TrackTableViewCell):
            cell.item = tracks[indexPath.row]
        default:
            break
        }
        return cell
    }
}
