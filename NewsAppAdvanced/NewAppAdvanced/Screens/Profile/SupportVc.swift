//
//  SupportVc.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 20.10.2023.
//

import UIKit

class SupportVc: UIViewController {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "support")
        return imageView
    }()
    
    private lazy var headLabel = NewsTitleLabel(textAlignment: .center, fontSize: 25)
    private lazy var secoLabel = NewsSecondaryTitleLabel(fontSize: 20)
    private lazy var user1 =  UserContactCardVC(userName: "Yaşar Duman",userEmail: "01.yasarduman@gmail.com" ,userImageName: "userName")
    private lazy var user2 =  UserContactCardVC(userName: "Erislam Nurluyol", userEmail: "nurluyolerislam@gmail.com" ,userImageName: "userName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureImageView()
        configureHeadText()
        configrueContactUser()
    }
    
    private func configureImageView(){
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                         size: .init(width: 0, height: 250)
        )
    }
    
    private func configureHeadText(){
        view.addSubview(headLabel)
        view.addSubview(secoLabel)
        
        headLabel.text = "Get In Touch"
        secoLabel.text = "If you have any inquiries get in touch with us. We'll be happy to help you"
        
        headLabel.anchor(top: imageView.bottomAnchor)
        headLabel.centerXInSuperview()
        
        secoLabel.numberOfLines = 2
        secoLabel.textAlignment = .center
        secoLabel.anchor(top: headLabel.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 20, left: 20, bottom: 0, right: 20)
        )
    }
    
    private func configrueContactUser() {
        view.addSubview(user1.view)
        view.addSubview(user2.view)
        
        user1.view.anchor(top: secoLabel.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                          size: .init(width: 0, height: 100)
        )
        user1.view.centerXInSuperview()
        
        user2.view.anchor(top: user1.view.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                          size: .init(width: 0, height: 100)
        )
        user2.view.centerXInSuperview()
    }
}
