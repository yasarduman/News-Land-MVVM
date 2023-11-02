//
//  HomeTableViewCell.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 25.10.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let reuseID = "HomeTableViewCell"
    
    var news : News? = nil
    
    //MARK: - UI Elementsw
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    lazy var timeSincePostLabel: UILabel = {
        let label = NewsTitleLabel(textAlignment: .natural, fontSize: 12)
        label.textColor = .secondaryLabel
        label.text = "1 min ago"
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = NewsTitleLabel(textAlignment: .natural, fontSize: 16)
        label.textColor = .label
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helper Functions
    private func configureUI() {
        configureContainerView()
        configureImageView()
        configureLabels()
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: UIEdgeInsets(top: 10,
                                                   left: 10,
                                                   bottom: 10,
                                                   right: 10))
        
    }
    
    private func configureImageView() {
        containerView.addSubview(newsImageView)
        newsImageView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor,
                             leading: containerView.safeAreaLayoutGuide.leadingAnchor,
                             bottom: containerView.safeAreaLayoutGuide.bottomAnchor,
                             size: CGSize(width: 120, height: 120))
    }
    
    private func configureLabels() {
        containerView.addSubviewsExt(titleLabel,timeSincePostLabel)
        
        titleLabel.anchor(top: containerView.topAnchor,
                          leading: newsImageView.trailingAnchor,
                          trailing: containerView.trailingAnchor,
                          padding: UIEdgeInsets(top: 10,
                                                left: 10,
                                                bottom: 0,
                                                right: 10))
        
        timeSincePostLabel.anchor(leading: titleLabel.leadingAnchor,
                                  bottom: containerView.bottomAnchor,
                                  trailing: titleLabel.trailingAnchor,
                                  padding: UIEdgeInsets(top: 0,
                                                        left: 0,
                                                        bottom: 10,
                                                        right: 0))
    } 
}
