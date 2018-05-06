//
//  TrackTableViewCellTests.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/24.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import ios_itunes_search

final class TrackTableViewCellTests: XCTestCase {
    
    let dataSource = FakeDataSource()
    var tableView: UITableView!
    var cell: TrackTableViewCell!
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
            as? SearchViewController else {
                XCTFail("SearchViewControllerのインスタンス生成失敗")
                return
        }
        
        searchVC.loadView()
        
        tableView = searchVC.tableView
        tableView.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier,
                                              for: IndexPath(row: 0, section: 0)) as! TrackTableViewCell
    }
    
    
    func testTrackNameLabel() {
        
        let dummy = DummyResponse().searchApiJSONString()
        let dummyData = dummy.data(using: .utf8)!
        let tracks = try! JSONDecoder().decode(Tracks.self, from: dummyData)

        cell.item = tracks.results.first
        
        XCTAssertEqual(cell.trackNameLabel.text, "桜")
    }
}

extension TrackTableViewCellTests {
    
    final class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
