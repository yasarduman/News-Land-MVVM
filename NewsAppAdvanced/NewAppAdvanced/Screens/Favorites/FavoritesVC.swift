//
//  FavoritesVC.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 25.10.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    //MARK: - Variables
    let vm: FavoritesVM
    var news: [News] = []
    
    //MARK: - UI Elements
    let tableView = UITableView()
    
    //MARK: - Initializers
    init() {
        self.vm = FavoritesVM()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshUI()
    }
        
    //MARK: - Helper Functions
    private func refreshUI() {
        vm.fetchFavorites { news in
            self.news = news
            self.tableView.reloadData()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
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
        navigationItem.title = "Favorites"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseID)
    }
}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseID,
                                                 for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        
        let news = news[indexPath.row]
        
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
    
    //Kullanıcı TabelView deki bir hücreyi sag kaydırınca tetiklenir
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //silme Buttonu
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            (contextualAction, view, boolValue) in
            
            let news = self.news[indexPath.row]
            self.vm.removeFromFavorites(news: news)
            self.refreshUI()
            
        }
   
        //oluşturulan actionlar TableView üzerine eklenir
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = news[indexPath.row]
        
        navigationController?.pushViewController(DetailVC(news: news), animated: true)
    }
}
