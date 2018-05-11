//
//  TrackTableViewCell.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

protocol TrackIconViewInput: class {
    func setTrackIconModel(trackIconModel: TrackIconModel)
}

final class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!

    private var presenter: TrackIconPresenter?
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var height: CGFloat {
        return 44
    }
    
    var item: TrackEntity? {
        didSet { set(track: item) }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPresenter()
    }
    
    private func set(track: TrackEntity?) {
        guard let track = track else { return }
        iconImageView.image = nil
        presenter?.fetchTrackIcon(track: track)
        trackNameLabel.text = track.trackName
    }

    private func setupPresenter() {
        let dataStore = TrackIconDataStoreImpl()
        let repository = TrackIconRepositoryImpl(dataStore: dataStore)
        let useCase = TrackIconUseCaseImpl(trackIconRepository: repository)
        presenter = TrackIconPresenterImpl(useCase: useCase, viewInput: self)
    }
}

// MARK: - TrackIconViewInput
extension TrackTableViewCell: TrackIconViewInput {
    
    func setTrackIconModel(trackIconModel: TrackIconModel) {
        iconImageView.image = trackIconModel.trackIcon
    }
}
