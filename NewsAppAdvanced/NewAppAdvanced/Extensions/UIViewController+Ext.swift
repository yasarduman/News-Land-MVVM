//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit
import SafariServices

extension UIViewController {
    // MARK: - Custom Alerts
    func presentNewsAlert(title: String, message: String, buttonTitle: String) {
            let alertVC = NewsAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
    }
    
//How to use it ? ->> presentGFAlert(title: "Empty Username", message: "Please enter a username. We need to know wgo to look for 😃", buttonTitle: "Ok")
    
    
// Presents a default error alert with a standard message.
    func presentDefualtError() {
        let alertVC = NewsAlertVC(title: "Something Wnt Wrong !",
                                message: "We were unable to complete your task at this time . Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        self.present(alertVC, animated: true)
        
    }
    
    // MARK: - Safari View Controller
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    /*
     
     
     func didTapGitHubProfile(for user: User) {
         guard let url = URL(string: user.htmlUrl) else {
             presentGFAlert(title: "Invalid URL", message: "the url attached to this url is invalid.", buttonTitle: "Ok")
             return
         }
         presentSafariVC(with: url)
     }
     
     
     */
    

}
