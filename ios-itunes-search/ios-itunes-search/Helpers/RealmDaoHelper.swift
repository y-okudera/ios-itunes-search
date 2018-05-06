//
//  RealmDaoHelper.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmDaoHelper <T: RealmSwift.Object> {
    
    let realm: Realm
    
    init() {
        do {
            if RealmDaoHelper.isTesting() {
                // XCTest実行の場合はUT用のConfigurationを設定
                realm = try Realm(configuration: UTRealm.makeRealmConfig())
            } else {
                realm = try Realm()
            }
        } catch (let error) {
            print(error.localizedDescription)
            fatalError("RealmDaoHelper initialize error.")
        }
    }
    
    /// XCTest実行中かどうかチェックする
    ///
    /// - Returns: true: XCTest実行中, false: XCTest実行中でない
    static func isTesting() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    // MARK: - newId
    
    /// 新規主キー発行
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            //primaryKey未設定
            return nil
        }
        return (realm.objects(T.self).max(ofProperty: key) as Int? ?? 0) + 1
    }
    
    // MARK: - find
    
    /// 全件取得
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }
    
    /// 1件目のみ取得
    func findFirst() -> T? {
        return findAll().first
    }
    
    /// 指定キーのレコードを取得
    func findFirst(key: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    /// 最後のレコードを取得
    func findLast() -> T? {
        return findAll().last
    }
    
    // MARK: - add
    
    /// レコード追加を取得
    func add(d :T) {
        do {
            try realm.write {
                realm.add(d)
            }
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - update
    
    /// T: RealmSwift.Object で primaryKey()が実装されている時のみ有効
    func update(d: T, block:(() -> Void)? = nil) -> Bool {
        do {
            try realm.write {
                block?()
                realm.add(d, update: true)
            }
            return true
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        return false
    }
    
    // MARK: - delete
    
    /// レコード削除
    func delete(d: T) {
        do {
            try realm.write {
                realm.delete(d)
            }
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    /// レコード全削除
    func deleteAll() {
        let objs = realm.objects(T.self)
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
}
