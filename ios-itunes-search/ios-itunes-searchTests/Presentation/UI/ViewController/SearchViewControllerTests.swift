//
//  SearchViewControllerTests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/24.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class SearchViewControllerTests: XCTestCase {
    
    var searchViewController: SearchViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
            as? SearchViewController else {
                XCTFail("SearchViewControllerのインスタンス生成失敗")
                return
        }
        searchViewController = vc
        
        searchViewController.loadView()
        searchViewController.viewDidLoad()
    }
    
    func testUISearchBarDelegate() {
        XCTAssertNotNil(searchViewController.searchBar.delegate)
    }
    
    func testUITableViewDelegate() {
        XCTAssertNotNil(searchViewController.tableView.delegate)
    }
    
    func testUITableViewDataSource() {
        XCTAssertNotNil(searchViewController.tableView.dataSource)
    }
    
    func testDefaultNavigationTitle() {
        XCTAssertEqual(searchViewController.navigationItem.title, "音楽検索")
    }
    
    func testDefaultSearchBarText() {
        XCTAssertEqual(searchViewController.searchBar.text, "")
    }
}
