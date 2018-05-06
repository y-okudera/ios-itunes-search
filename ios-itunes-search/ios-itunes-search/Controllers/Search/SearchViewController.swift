//
//  SearchViewController.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import SVProgressHUD
import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let searchAPI = ItunesSearchAPI()
    private let provider = TracksProvider()
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - private methods

    private func setup() {
        searchAPI.loadable = self
        searchBar.enablesReturnKeyAutomatically = true
        tableView.tableFooterView = UIView()
        tableView.dataSource = provider
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: NSLocalizedString("WARNING", comment: ""),
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: NSLocalizedString("OK", comment: ""),
            style: .default,
            handler:nil
        )
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func clearList() {
        searchBar.text = ""
        navigationItem.title = NSLocalizedString("SEARCH_MUSIC", comment: "")
        provider.set(tracks: [])
    }
}

// MARK: - ItunesSearchLoadable
extension SearchViewController: ItunesSearchLoadable {
    
    func setResult(result: ItunesSearchAPIStatus) {
        switch result {
        case .loaded(tracks: let tracks):
            navigationItem.title = tracks.results.first?.artistName ?? NSLocalizedString("UNKNOWN", comment: "")
            provider.set(tracks: tracks.results)

        case .offline:
            clearList()
            showAlert(message: NSLocalizedString("ITUNES_SEARCH_UNREACHABLE", comment: ""))
            
        case .emptyData:
            clearList()
            showAlert(message: NSLocalizedString("ITUNES_SEARCH_EMPTY", comment: ""))
            
        case .error:
            clearList()
            showAlert(message: NSLocalizedString("ITUNES_SEARCH_FAILED", comment: ""))
            
        }
        
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        SVProgressHUD.stv.show()
        searchBar.resignFirstResponder()
        searchAPI.load(term: term)
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
        
        if provider.cellType() == .track {
            return TrackTableViewCell.height
        }
        return tableView.frame.height
    }
}
