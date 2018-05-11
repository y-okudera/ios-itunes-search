//
//  SearchViewController.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import SVProgressHUD
import UIKit

protocol TrackViewInput: class {
    func setTrackListEntity(trackListEntity: TrackListEntity)
    func changedStatus(status: TrackStatus)
}

final class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: TrackPresenter?
    private var tracks = TrackListEntity()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private methods

    private func setup() {
        searchBar.enablesReturnKeyAutomatically = true
        tableView.delegate = self
        tableView.dataSource = self
        setupPresenter()
    }

    private func setupPresenter() {
        let dataStore = TrackDataStoreImpl()
        let repository = TrackRepositoryImpl(dataStore: dataStore)
        let useCase = TrackUseCaseImpl(trackRepository: repository)
        presenter = TrackPresenterImpl(useCase: useCase, viewInput: self)
    }

    private func clearList() {
        searchBar.text = ""
        navigationItem.title = NSLocalizedString("SEARCH_MUSIC", comment: "")
        tracks = TrackListEntity()
        tableView.reloadData()
    }

    private func cellType() -> CellType {
        return tracks.results.isEmpty ? .empty : .track
    }
}

// MARK: - TrackViewInput
extension SearchViewController: TrackViewInput {

    func setTrackListEntity(trackListEntity: TrackListEntity) {
        tracks = trackListEntity
        navigationItem.title = trackListEntity.results.first?.artistName ?? NSLocalizedString("UNKNOWN", comment: "")
        tableView.reloadData()
    }

    func changedStatus(status: TrackStatus) {

        switch status {
        case .loading:
            if !SVProgressHUD.isVisible() {
                SVProgressHUD.stv.show()
            }
        case .normal:
            SVProgressHUD.dismiss()
        case .empty(let message), .searchFailed(let message), .unreachable(let message):
            clearList()
            SVProgressHUD.dismiss()
            showAlert(warningMessage: message)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        searchBar.resignFirstResponder()
        presenter?.searchTracks(term: term)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.canResignFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if cellType() == .track {
            return TrackTableViewCell.height
        }
        return tableView.frame.height
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.results.isEmpty ? 1 : tracks.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = self.cellType()
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellType.identifier,
            for: indexPath
        )
        switch (cellType, cell) {
        case (.track, let cell as TrackTableViewCell):
            cell.item = tracks.results[indexPath.row]
        default:
            break
        }
        return cell
    }
}
