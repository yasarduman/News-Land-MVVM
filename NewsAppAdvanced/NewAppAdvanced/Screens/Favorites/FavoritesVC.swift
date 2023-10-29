//
//  FavoritesVC.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 25.10.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseID,
                                                 for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    //Kullanıcı TabelView deki bir hücreyi sag kaydırınca tetiklenir
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //silme Buttonu
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            (contextualAction, view, boolValue) in
            //print("\(self.ulkeler[indexPath.row]) yi sil")
            
            // Hücre Silme işlemi
            //self.ulkeler.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
   
        //oluşturulan actionlar TableView üzerine eklenir
        return UISwipeActionsConfiguration(actions: [silAction])
    }


}

extension FavoritesVC: UITableViewDelegate {

}
