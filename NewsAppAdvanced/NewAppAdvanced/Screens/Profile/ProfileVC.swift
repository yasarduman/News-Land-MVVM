//
//  ProfileVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 19.10.2023.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    //MARK: - Variables
    private let vm = ProfileVM()
    private lazy var TopContenView          = UIView()
    private lazy var imageView              = UIImageView()
    private lazy var userName               = NewsTitleLabel(textAlignment: .center, fontSize: 15)
    private lazy var segLabel               = NewsTitleLabel(textAlignment: .center, fontSize: 15)
   
    private let customTableVC = CustomTableVC()
   
    //MARK: - Initializers
    init() {
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
        
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        
        //image tıklana bilir hale getirdik
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooeseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.anchor(size: .init(width: 90, height: 90))
        
        imageView.centerXInSuperview()
        imageView.centerYInSuperview()
        
        vm.fetchUserPhoto { url in
                Task {
                    self.imageView.image = await NetworkManager.shared.downloadImage(from: url)
                }
        }
        
        vm.fetchUserName { userName in
            self.userName.text = userName
        }
        userName.anchor(top: imageView.bottomAnchor,
                        padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        userName.centerXInSuperview()
        
    }
 
    //image Func
    @objc func chooeseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        vm.uploadUserPhoto(imageData: imageView.image!)
        self.dismiss(animated: true)
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

