//
//  CustomTableVC.swift
//  NewsApp
//
//  Created by Yaşar Duman on 12.10.2023.
//


import UIKit
import FirebaseAuth

// MARK: - Section Data Structure
struct Section {
    let title: String
    let options: [SettingsOptionType]
}

// MARK: - Settings Option Type Enumeration
enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

// MARK: - Switch Option Data Structure
struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgrondColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

// MAK: - Settings Option Data Structure
struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgrondColor: UIColor
    let handler: (() -> Void)
}

class CustomTableVC : UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
       return table
    }()
    
    var models = [Section]()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configure()
    }
    
    // MARK: - Configure
    private func setupTableView() {
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            tableView.backgroundColor = .systemBackground
            tableView.separatorStyle = .none
        }
    
    func configure() {
      
        let isDarkModeOn = UserDefaults.standard.bool(forKey: "DarkMode")
          
        models.append(Section(title: "", options: [
            
            .switchCell(model: SettingsSwitchOption(title: "Dark Mode", icon: UIImage(systemName: "moon.stars"), iconBackgrondColor: NewsColor.purple3, handler: {
                // Handle switch option
            }, isOn: isDarkModeOn)),
            
            .staticCell(model: SettingsOption(title: "Change Password", icon: UIImage(systemName: "exclamationmark.lock.fill"), iconBackgrondColor: NewsColor.purple3, handler: {
                let vc = ChangePasswordVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })),
            .staticCell(model: SettingsOption(title: "Help and Support", icon: UIImage(systemName: "questionmark.circle"), iconBackgrondColor: NewsColor.purple3, handler: {
                let vc = SupportVc()
                self.navigationController?.pushViewController(vc, animated: true)
            })),
            .staticCell(model: SettingsOption(title: "Log out", icon: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), iconBackgrondColor: NewsColor.purple3, handler: {
                do {
                    try Auth.auth().signOut()
                    let loginVC = LoginVC()
                    let nav = UINavigationController(rootViewController: loginVC)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true, completion: nil)
                    
                } catch  {
                    print(error.localizedDescription )
                }
            })),
        ]))
    }
    

    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        case .switchCell(let model):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            model.handler()
            
        case .switchCell(let model):
            model.handler()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired row height
        return 60.0
    }
}
