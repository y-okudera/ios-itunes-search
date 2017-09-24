//
//  TrackTableViewCell.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var height: CGFloat {
        return 44
    }
    
    var item: Track? {
        didSet { set(track: item) }
    }
    
    private func set(track: Track?) {
        trackNameLabel.text = track?.trackName
        iconImageView.image = nil
        loadImage(track: track)
    }
    
    private func loadImage(track: Track?) {
        guard let track = track else { return }
        
        // DBにイメージデータが保存されている場合は、それを描画する
        if let iconImage = TrackIconImageDao.findByID(trackId: track.trackId),
            let imageData = iconImage.imageData {
            iconImageView.image = UIImage(data: imageData)
            return
        }
        
        guard let imageUrl = URL.init(string: track.artworkUrl100) else { return }
        let urlRequest = URLRequest(url: imageUrl)
        let urlSessionConfig = URLSessionConfiguration.default
        urlSessionConfig.timeoutIntervalForRequest = 30.0
        urlSessionConfig.timeoutIntervalForResource = 60.0
        
        let urlSession = URLSession(configuration: urlSessionConfig)
        urlSession.dataTask(with: urlRequest) { [weak self] data, _, error in
            
            if let error = error {
                print("Failed to download icon.\n->\(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.iconImageView.image = UIImage(data: data)
                let downloadedIconImage = TrackIconImage()
                downloadedIconImage.trackId = track.trackId
                downloadedIconImage.imageData = data
                TrackIconImageDao.add(model: downloadedIconImage)
            }
            }.resume()
    }
}
