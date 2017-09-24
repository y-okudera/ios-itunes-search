//
//  UTRealm.swift
//  ios-itunes-searchTests
//
//  Created by OkuderaYuki on 2017/09/24.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import RealmSwift

final class UTRealm {
    
    private static let utDirectory = NSSearchPathForDirectoriesInDomains(
        .documentDirectory,
        .userDomainMask,
        true)[0].appendingPathComponent("UnitTest")
    
    /// UT用のRealmConfigurationを生成
    ///
    /// - Returns: UT用のRealmConfiguration
    static func makeRealmConfig() -> Realm.Configuration {
        return Realm.Configuration(fileURL: URL(fileURLWithPath: getUTRealmPath()))
    }
    
    /// Documentsディレクトリ直下にUnitTestディレクトリが存在したら、削除する
    static func removeUTDirectory() {
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: utDirectory) { return }
        
        do {
            try fileManager.removeItem(atPath: utDirectory)
        } catch (let error) {
            fatalError("UnitTestディレクトリ削除失敗\n\(error.localizedDescription)")
        }
    }
    
    // MARK: - private methods
    
    /// Documentsディレクトリ直下にUnitTestディレクトリが存在しなければ、生成する
    private static func createUTDirectory() {
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: utDirectory) { return }
        
        do {
            try fileManager.createDirectory(atPath: utDirectory,
                                            withIntermediateDirectories: false,
                                            attributes: nil)
        } catch (let error) {
            fatalError("UnitTestディレクトリ作成失敗\n\(error.localizedDescription)")
        }
    }
    
    /// UT用のrealmのPATHを取得する
    private static func getUTRealmPath() -> String {
        
        createUTDirectory()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateString = dateFormatter.string(from: Date())
        let utTestRealmPath = utDirectory.appendingPathComponent(dateString + ".realm")
        print("UT用のRealmのPATH:\(utTestRealmPath)")
        return utTestRealmPath
    }
}

private extension String {
    
    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
}
