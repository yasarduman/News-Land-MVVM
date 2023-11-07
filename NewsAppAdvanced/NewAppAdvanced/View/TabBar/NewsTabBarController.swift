//
//  NewsTabBarController.swift
//  NewsApp
//
//  Created by Yaşar Duman on 9.10.2023.
//

import UIKit

class NewsTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Özelleştirilmiş tab bar sınıfını kullanarak tab bar'ı ayarlayın
         lazy var customTabBar = CustomTabBar()
         self.setValue(customTabBar, forKey: "tabBar")
         
        // Tab bar arka plan rengini beyaz yapın
        UITabBar.appearance().backgroundColor = .clear

          // Seçili olan öğelerin rengini turuncu yapın
        UITabBar.appearance().tintColor = NewsColor.purple1
       
          // Seçilmeyen öğelerin rengini gri yapın
        UITabBar.appearance().unselectedItemTintColor = .systemGray
        
        viewControllers = [
            createHomeNC(),
            createSearchNC(),
            createFavoritesNC(),
            createProfileNC()
        ]
       
    }
    // MARK: - Home Navigation Controller 🏠
    func createHomeNC() -> UINavigationController {
        let homeVC        = HomeVC()

        
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         tag: 0)
        
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        return UINavigationController(rootViewController: homeVC)
    }
 
    // MARK: - Search Navigation Controller 🔍
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Discover"
       
       
        searchVC.tabBarItem = UITabBarItem(title: "Search",
                                           image: UIImage(systemName: "magnifyingglass"),
                                           tag: 1)
        
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // MARK: - Favorites Navigation Controller ⭐️
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC        = FavoritesVC()
        
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites",
                                           image: UIImage(systemName: "bookmark"),
                                           tag: 2)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
//     MARK: - Profile Navigation Controller ⚙️
        func createProfileNC() -> UINavigationController {
            let profileVC        = ProfileVC()
    
            profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                               image: UIImage(systemName: "person.crop.circle"),
                                               tag: 3)
    
            return UINavigationController(rootViewController: profileVC)
        }
    
}
