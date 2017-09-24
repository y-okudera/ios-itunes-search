//
//  SearchViewController.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2017/09/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        tableView.tableFooterView = UIView()
        tableView.dataSource = provider
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func clearList() {
        searchBar.text = ""
        navigationItem.title = "音楽検索"
        provider.set(tracks: [])
    }
}

// MARK: - ItunesSearchLoadable
extension SearchViewController: ItunesSearchLoadable {
    
    func setResult(result: ItunesSearchAPIStatus) {
        switch result {
        case .loaded(tracks: let tracks):
            navigationItem.title = tracks.results.first?.artistName ?? "不明"
            provider.set(tracks: tracks.results)

        case .offline:
            clearList()
            showAlert(message: "通信環境の良い場所で再度お試しください。")
            
        case .emptyData:
            clearList()
            showAlert(message: "該当の音楽がみつかりません。")
            
        case .error:
            clearList()
            showAlert(message: "検索に失敗しました。")
            
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
