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
    func pushDetail(value: News)
}

// MARK: - Home View Controller
class HomeVC: UIViewController  {
    
    //MARK: - UI Elements
    private lazy var showNotificationsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease")!,
                                     menu: addMenuItems())
        button.tintColor = .label
        return button
    }()
    
    private lazy var carousel: NewsCarouselView = {
        let carousel = NewsCarouselView()
        carousel.delegate = self
        return carousel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseID)
        return tableView
    }()
    
    // MARK: Properties
    private lazy var vm: HomeVM = {
        let vm = HomeVM()
        vm.delegate = self
        return vm
    }()
    private lazy var newsArr: [News] = []
    
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
        vm.getNewsTopHeadLines()
    }
    
    private func updateUI(news: [News]? = nil){
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
    }
    
    // MARK: - Menu Action
    private func addMenuItems() -> UIMenu {
        return UIMenu(title: "Categories", options: .displayInline, children: [
            UIAction(title:"General", image: UIImage(systemName: "globe")) { _ in
                self.vm.getNewsCategory(category: "General")
            },
            UIAction(title:"Business", image: UIImage(systemName: "dollarsign")) { _ in
                self.vm.getNewsCategory(category: "Business")
            },
            UIAction(title:"Entertainment", image: UIImage(systemName: "gamecontroller")) { _ in
                self.vm.getNewsCategory(category: "Entertainment")
            },
            UIAction(title:"Health", image: UIImage(systemName: "cross.case")) { _ in
                self.vm.getNewsCategory(category: "Health")
            },
            UIAction(title:"Science", image: UIImage(systemName: "pill.circle")) { _ in
                self.vm.getNewsCategory(category: "Science")
            },
            UIAction(title:"Sports", image: UIImage(systemName: "baseball")) { _ in
                self.vm.getNewsCategory(category: "Sports")
            },
            UIAction(title:"Technology", image: UIImage(systemName: "laptopcomputer")) { _ in
                self.vm.getNewsCategory(category: "Technology")
            }
        ])
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
    
    func pushDetail(value: News) {
        navigationController?.pushViewController(DetailVC(news: value), animated: true)
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
        } else {
            cell.newsImageView.image = UIImage(systemName: "x.circle")
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
