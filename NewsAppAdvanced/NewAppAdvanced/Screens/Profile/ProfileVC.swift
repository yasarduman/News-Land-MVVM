//
//  ProfileVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 19.10.2023.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - Variables
    let vm: ProfileVM
    
    let TopContenView          = UIView()
    let imageView              = UIImageView()
    let userName               = NewsTitleLabel(textAlignment: .center, fontSize: 15)
    let segLabel               = NewsTitleLabel(textAlignment: .center, fontSize: 15)
    
    private let customTableVC = CustomTableVC()
    
    
    //MARK: - Initializers
    init() {
        self.vm = ProfileVM()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = NewsColor.purple2
        view.backgroundColor = .systemBackground
        configureTopContent()
        configureTableView()
    }
    
    private func configureTopContent() {
        view.addSubview(TopContenView)
        TopContenView.addSubview(imageView)
        TopContenView.addSubview(userName)
        
        
        
        TopContenView.anchor(top: view.topAnchor,
                             leading: view.leadingAnchor,
                             trailing: view.trailingAnchor,
                             size: .init(width: 0, height: 250)
        )
        
        imageView.image = UIImage(named: "userName")
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.anchor(size: .init(width: 90, height: 90))
        
        imageView.centerXInSuperview()
        imageView.centerYInSuperview()
        
        vm.fetchUserName { userName in
            self.userName.text = userName
        }
        userName.anchor(top: imageView.bottomAnchor,
                        padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        userName.centerXInSuperview()
        
    }
    
    private func configureTableView(){
        addChild(customTableVC)
        view.addSubview(customTableVC.view)
        customTableVC.didMove(toParent: self)
        
        let custWith = customTableVC.view.frame.size.width
        let custHeight = customTableVC.view.frame.size.height
        
        customTableVC.view.anchor(top: TopContenView.bottomAnchor,
                                  size: .init(width: custWith, height: custHeight)
        )
        
    }
}
