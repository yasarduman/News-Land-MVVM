//
//  Constants.swift
//  GitNewsAppAdvancedhubFollowers
//
//  Created by Yaşar Duman on 17.10.2023.
//

import Foundation
import UIKit
// MARK: - Color
enum NewsColor {
    static let purple1                    = UIColor(red: 0.49, green: 0.34, blue: 0.76, alpha: 1.00)
    static let purple2                    = UIColor(red: 0.69, green: 0.51, blue: 0.99, alpha: 1.00)
    static let purple3                    = UIColor(red: 0.88, green: 0.81, blue: 1.00, alpha: 1.00)
    static let black                      = UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)

}


// MARK: - Screen Size Constants
enum ScreenSize {
    static let width                      = UIScreen.main.bounds.size.width
    static let height                     = UIScreen.main.bounds.size.height
    static let maxLength                  = max(ScreenSize.width, ScreenSize.height)
    static let minLength                  = min(ScreenSize.width, ScreenSize.height)
}

// MARK: - Device Type Constants
enum DeviceTypes {
    static let idiom                      = UIDevice.current.userInterfaceIdiom
    static let nativeScale                = UIScreen.main.nativeScale
    static let scale                      = UIScreen.main.scale
    static let is_iPhoneSE                = idiom == .phone && ScreenSize.maxLength == 568.0
    static let is_iPhone8Standard         = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let is_iPhone8Zoomed           = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let is_iPhone8PlusStandard     = idiom == .phone && ScreenSize.maxLength == 736.0
    static let is_iPhone8PlusZoomed       = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let is_iPhoneX                 = idiom == .phone && ScreenSize.maxLength == 812.0
    static let is_iPhoneXsMaxAndXr        = idiom == .phone && ScreenSize.maxLength == 896.0
    static let is_iPad                    = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return is_iPhoneX || is_iPhoneXsMaxAndXr
    }
}

/*
 örnek kullanım
 
 let topConstraintConstant: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 20 : 80
 
 NSLayoutConstraint.activate([
     logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
     logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     logoImageView.heightAnchor.constraint(equalToConstant: 200),
     logoImageView.widthAnchor.constraint(equalToConstant: 200)
 ])

 */
