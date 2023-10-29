//
//  HomeVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 18.10.2023.
//

import UIKit

// MARK: - Protocols
protocol HomeProtocol {
    func saveDatas(value: [News])
}

// MARK: - Home View Controller
class HomeVC: UIViewController  {
    
    //MARK: - UI Elements
    private lazy var showNotificationsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease")?.withTintColor(.label, renderingMode: .alwaysOriginal),
                                     style: .done,
                                     target: self,
                                     action: #selector(showNotifications))
        button.menu = addMenuItems()
        return button
    }()
    
    let carousel                      = NewsCarouselView()
    let tableView                     = UITableView()
    
    // MARK: Properties
    private let vm = HomeVM()
    private lazy var  newsArr: [News] = []
    
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
        
        vm.delegate = self
        vm.getNewsTopHeadLines()
    }
    
    private func updateUI( news: [News]? = nil){
        newsArr = news!
        carousel.news = news
        tableView.reloadData()
    }
    
    // MARK: Navigation Bar Configuration
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
    
    // MARK: CarouselView Configuration
    private func configureCarouselView() {
        view.addSubview(carousel)
        carousel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                        size: CGSize(width: .zero, height: 300))
    }
    
    // MARK: TableView   Configuration
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
    
    // MARK: - Menu Action
    private func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title:"Business", image: UIImage(systemName: "rectangle.inset.filled.and.person.filled"), handler: { (_) in
                self.vm.getNewsCategory(category: "Business")
            }),
            UIAction(title:"Entertainment", image: UIImage(systemName: "gamecontroller"), handler: { (_) in
                self.vm.getNewsCategory(category: "Entertainment")
            }),
            UIAction(title:"General", image: UIImage(systemName: "globe"), handler: { (_) in
                self.vm.getNewsCategory(category: "General")
            }),
            UIAction(title:"Health", image: UIImage(systemName: "cross.case"), handler: { (_) in
                self.vm.getNewsCategory(category: "Health")
            }),
            UIAction(title:"Science", image: UIImage(systemName: "pill.circle"), handler: { (_) in
                self.vm.getNewsCategory(category: "Science")
            }),
            UIAction(title:"Sports", image: UIImage(systemName: "baseball"), handler: { (_) in
                self.vm.getNewsCategory(category: "Sports")
            }),
            UIAction(title:"Technology", image: UIImage(systemName: "laptopcomputer"), handler: { (_) in
                self.vm.getNewsCategory(category: "Technology")
            }),
            
        ])
        return menuItems
    }

    // MARK: - Actions
    @objc func showNotifications() {
        print("bell tapped")
    }
}
// MARK: - Home Protocol Implementation
extension HomeVC: HomeProtocol {
    func saveDatas(value: [News]) {
        DispatchQueue.main.async {
            self.updateUI(news: value)
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseID,
                                                 for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        
        let news = newsArr[indexPath.row]
        
        if let title = news.title {
            cell.titleLabel.text = title
        }
        
        if let imageURL = news.urlToImage {
            Task {
                cell.newsImageView.image = await NetworkManager.shared.downloadImage(from: imageURL)
            }
        }

        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsArr[indexPath.row]
        
        navigationController?.pushViewController(DetailVC(news: news), animated: true)
    }
}
