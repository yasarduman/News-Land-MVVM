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
        button.menu = addMenuItems()
            
        return button
    }()
    
    let carousel = NewsCarouselView()
    
    let tableView = UITableView()
    
    var newsArr : [News] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemBackground
    }

    //MARK: - Helper Functions
    private func configureUI() {
        getNewsTopHeadLines()
        configureNavigationBar()
        configureCarouselView()
        configureTableView()
    }
    
    private func updateUI( news: [News]? = nil, categoryNews: [News]? = nil){
        newsArr = news!
        
        carousel.news = categoryNews
        
        tableView.reloadData()
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
    // MARK: - Menu Action
    private func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title:"Business", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "Business")
            }),
            UIAction(title:"Entertainment", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "Entertainment")
            }),
            UIAction(title:"General", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "General")
            }),
            UIAction(title:"Health", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "Health")
            }),
            UIAction(title:"Science", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "Science")
            }),
            UIAction(title:"Sports", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "Sports")
            }),
            UIAction(title:"Technology", image: UIImage(systemName: "house"), handler: { (_) in
                self.getNewsCategory(category: "Technology")
            }),
            
        ])
        return menuItems
    }
    // MARK: - Network
    func getNewsCategory(category: String) {
        Task{
            do {
                
                let getNewsResponseCategory = try await NetworkManager.shared.getNewsCategoriy(categoryy: category)
                self.updateUI(news: getNewsResponseCategory.articles, categoryNews: getNewsResponseCategory.articles)
    
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    self.presentDefualtError()
                }
                
                
            }
        }
      
    }
    
    func getNewsTopHeadLines() {
        Task{
            do {
                let getNewsResponse = try await NetworkManager.shared.getNews()
                self.updateUI(news: getNewsResponse.articles, categoryNews: getNewsResponse.articles)
    
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    self.presentDefualtError()
                }
                
                
            }
        }
      
    }
    
    // MARK: - Actions
    @objc func showNotifications() {
        print("bell tapped")
    }
    
}

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
}

#Preview {
    NewsTabBarController()
}


