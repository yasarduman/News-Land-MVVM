//
//  HomeVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 18.10.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - UI Elements
    private lazy var showNotificationsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "bell")?.withTintColor(.label, renderingMode: .alwaysOriginal),
                                     style: .done,
                                     target: self,
                                     action: #selector(showNotifications))
        return button
    }()
    
    let carousel = NewsCarouselView()
    
    let tableView = UITableView()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemBackground
    }
    
    
    //MARK: - Helper Functions
    private func configureUI() {
        configureNavigationBar()
        configureCarouselView()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.label]
        navBarAppearance.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "News"
        
        navigationItem.rightBarButtonItem = showNotificationsButton
    }
    
    private func configureCarouselView() {
        view.addSubview(carousel)
        carousel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                        size: CGSize(width: .zero, height: 300))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: carousel.bottomAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseID)
    }
    
    @objc func showNotifications() {
        print("bell tapped")
    }
    
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseID,
                                                 for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        return cell
    }


}

extension HomeVC: UITableViewDelegate {

}

#Preview {
    NewsTabBarController()
}


