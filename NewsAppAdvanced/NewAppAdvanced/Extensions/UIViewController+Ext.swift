//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//


import UIKit

extension UIViewController {
    // MARK: - Custom Alerts
    func presentNewsAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = NewsAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        self.present(alertVC, animated: true)
    }
}
