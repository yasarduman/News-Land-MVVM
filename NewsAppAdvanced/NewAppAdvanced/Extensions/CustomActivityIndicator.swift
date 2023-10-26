//
// CustomActivityIndicator.swift
//  NewsAppAdvanced
//
//  Created by Yaşar Duman on 17.10.2023.
//


import UIKit
var activityView: UIActivityIndicatorView?

extension UIViewController {
        func showActivityIndicator() {
            activityView = UIActivityIndicatorView(style: .large)
            activityView?.center = self.view.center
            activityView?.color = .red
            self.view.addSubview(activityView!)
            activityView?.startAnimating()
        }
    
        func hideActivityIndicator(){
            if (activityView != nil){
                activityView?.stopAnimating()
            }
        }
}
