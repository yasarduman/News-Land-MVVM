//
//  SearchVC.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 25.10.2023.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate {
    private let searchController    = UISearchController(searchResultsController: nil)
    let tableView                   = UITableView()
    var newsArr : [News] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        getNewsTopHeadLines()
        createSearchBar()
        configureTableView()
    }
    
    private func updateUI( news: [News]? = nil){
        newsArr = news!
        
        tableView.reloadData()
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
    // MARK: - Network
    func getNewsTopHeadLines() {
        Task{
            do {
                let getNewsResponse = try await NetworkManager.shared.getNews()
                self.updateUI(news: getNewsResponse.articles)
    
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    self.presentDefualtError()
                }
                
                
            }
        }
      
    }
    
    
    func getNewsSearch(searc: String) {
        Task{
            do {
                let getNewsResponse = try await NetworkManager.shared.getNewsSearch(search: searc)
                self.updateUI(news: getNewsResponse.articles)
    
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    self.presentDefualtError()
                }
                
                
            }
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
            getNewsSearch(searc: searchText)
        } else {
            getNewsTopHeadLines()
        }
    
    }

}

#Preview{
    NewsTabBarController()
}
