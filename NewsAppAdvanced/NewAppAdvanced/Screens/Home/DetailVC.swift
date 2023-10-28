//
//  DetailVC.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 28.10.2023.
//

import UIKit

class DetailVC: UIViewController {
    //MARK: - Variables
    let news: News
    
    
    //MARK: - UI Elements
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var bookmarkButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                     style: .done,
                                     target: self,
                                     action: #selector(bookmarkButtonTapped))
        return button
    }()
    
    lazy var dateLabel: NewsSecondaryTitleLabel = {
        let label = NewsSecondaryTitleLabel(fontSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var titleLabel: NewsTitleLabel = {
        let label = NewsTitleLabel(textAlignment: .left, fontSize: 25, fontWeight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.systemFont(ofSize: 23)
        return textView
    }()
    
    
    //MARK: - Initializers
    init(news: News) {
        self.news = news
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
    
    
    //MARK: - Helper Functions
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureImageView()
        configureTitleLabel()
        configureDateLabel()
        configureDescriptonTextView()
    }
    
    func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.label]
        navBarAppearance.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = ""
        
        navigationItem.rightBarButtonItem = bookmarkButton
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor,
                         size: CGSize(width: .zero, height: 300))
        
        if let imageURL = news.urlToImage {
            Task {
                imageView.image = await NetworkManager.shared.downloadImage(from: imageURL)
            }
        }
    }
    
    func configureTitleLabel() {
        imageView.addSubview(titleLabel)
        titleLabel.anchor(leading: imageView.leadingAnchor,
                          bottom: imageView.bottomAnchor,
                          trailing: imageView.trailingAnchor,
                          padding: UIEdgeInsets(top: 0,
                                                left: 10,
                                                bottom: 10,
                                                right: 10))
        
        if let title = news.title {
            titleLabel.text = title
        }
    }
    
    func configureDateLabel() {
        imageView.addSubview(dateLabel)
        dateLabel.anchor(leading: imageView.leadingAnchor,
                         bottom: titleLabel.topAnchor,
                         trailing: imageView.trailingAnchor,
                         padding: UIEdgeInsets(top: 0,
                                               left: 10,
                                               bottom: 20,
                                               right: 10))
        
        if let date = news.publishedAt {
            dateLabel.text = date.convertToMonthYearFormat()
        }
    }
    
    func configureDescriptonTextView() {
        view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: imageView.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   padding: UIEdgeInsets(top: 10,
                                                         left: 10,
                                                         bottom: 10,
                                                         right: 10))
        
        if let description = news.description {
            descriptionTextView.text = description
        }
    }
    
    
    //MARK: - @Actions
    @objc func bookmarkButtonTapped() {
        print("bookmarkButtonTapped")
    }
}
