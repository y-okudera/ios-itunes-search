//
//  UIViViewController+Alert.swift
//  ios-itunes-search
//
//  Created by OkuderaYuki on 2018/05/09.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(warningMessage: String) {
        let alert = UIAlertController(
            title: "WARNING".localized(),
            message: warningMessage,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK".localized(),
            style: .default,
            handler:nil
        )
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
