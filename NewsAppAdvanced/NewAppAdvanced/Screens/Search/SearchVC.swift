//
//  SearchVC.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 25.10.2023.
//

import UIKit

// MARK: - Protocols
protocol SearchOutPut {
    func saveDatas(value: [News])
}

// MARK: - Search View Controller
class SearchVC: UIViewController, UITableViewDelegate {
    
    // MARK: - UI Elements
    private let searchController      = UISearchController(searchResultsController: nil)
    let tableView                     = UITableView()
    
    // MARK: - Properties
    private let vm: ISearchViewModel  = SearchVM()
    private lazy var newsArr : [News] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper Functions
    private func configureUI() {

        createSearchBar()
        configureTableView()
        
        vm.setDelegate(output: self)
        vm.getNewsTopHeadLines()
    }
    
    private func updateUI( news: [News]? = nil){
        newsArr = news!
        tableView.reloadData()
    }
    
    // MARK: - TableView Configure
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
// MARK: - Network VM Protocol
extension SearchVC: SearchOutPut {
    func saveDatas(value: [News]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateUI( news: value)
        }
    }
}

// MARK: - TableView
extension SearchVC: UITableViewDataSource {
    
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

//MARK: - SearchBar Methods

extension SearchVC: UISearchBarDelegate {
 
    private func createSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("Arama metni: \(searchText)")
        if !searchText.isEmpty {
            self.vm.getNewsSearch(searchTextt: searchText)
        } else {
            self.vm.getNewsTopHeadLines()
        }
    }
}

#Preview{
    NewsTabBarController()
}
