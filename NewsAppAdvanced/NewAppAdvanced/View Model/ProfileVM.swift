//
//  ProfileVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 19.10.2023.
//

import UIKit

// MARK: - ViewModel
class ProfileVM {
    // ViewModel, iş mantığını ve verileri yönetir.
    var isDarkModeOn: Bool = false

    func toggleDarkMode() {
        isDarkModeOn.toggle()
        // Dark Mode ayarlamalarını burada işleyin.
    }

    func changePassword() {
        // Parola değiştirme işlemini burada işleyin.
    }

    func showHelp() {
        // Yardım sayfasını açma işlemini burada işleyin.
    }

    func logout() {
        // Çıkış işlemini burada işleyin.
    }
}





