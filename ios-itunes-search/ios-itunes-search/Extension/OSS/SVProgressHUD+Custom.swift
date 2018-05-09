//
//  SVProgressHUD+Custom.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import SVProgressHUD

public extension SVProgressHUD {
    
    /// ユーザー操作に関する状態
    enum ManipulationType {
        /// ユーザー操作可能
        case permitted
        /// ユーザー操作禁止
        case prohibited
    }
    
    /// プロジェクト独自メソッドを定義（独自メソッドはstv経由で使う）
    enum stv {
        
        /// マスクのタイプを指定してインジケータを表示する
        /// - デフォルトはユーザー操作禁止・文言なし
        ///
        /// - Parameter manipulationType: ユーザー操作に関する状態 (default: .prohibited)
        /// - Parameter message: インジケータに表示する文字列 (default: nil)
        static func show(manipulationType: ManipulationType = .prohibited,
                         message: String? = nil) {
            
            switch manipulationType {
            case .permitted:
                SVProgressHUD.setDefaultMaskType(.none)
            case .prohibited:
                SVProgressHUD.setDefaultMaskType(.black)
            }
            
            if let message = message {
                SVProgressHUD.show(withStatus: message)
            } else {
                SVProgressHUD.show()
            }
        }
    }
}
