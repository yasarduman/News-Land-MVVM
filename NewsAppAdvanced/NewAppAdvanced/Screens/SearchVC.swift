//
//  SearchVC.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 25.10.2023.
//

import UIKit

class SearchVC: UIViewController {
    private let searchController                  = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        createSearchBar()
    }
}
//MARK: - SearchBar Methods

extension SearchVC: UISearchBarDelegate {
    
    
    private func createSearchBar() {
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: burda table Viewi Yenileme işlemi yapılacak txt e göre
        print("Arama metni: \(searchText)")
        
       
    }
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//        
//        guard let text = searchBar.text, !text.isEmpty else { return }
//      
//        APICaller.shared.search(with: text) { [weak self] result in
//            switch result {
//            case .success(let articles):
//                self?.articles = articles
//                
//                self?.viewModels = articles.compactMap({
//                    NewsTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "No Description", imageurl: URL(string: $0.urlToImage ?? ""))
//                    
//                    
//                })
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//                
//                
//            case.failure(let error):
//                print(error)
//            
//            }
//            }
//        
//     
//        
//    }
    
 
}

#Preview{
    NewsTabBarController()
}
