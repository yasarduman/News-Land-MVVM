//
//  NewsCarouselViewCell.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 23.10.2023.
//

import UIKit

class NewsCarouselViewCell: UICollectionViewCell {
    
    static let reuseID = "NewsCarouselViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font =  .systemFont(ofSize: 18, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = NewsColor.purple1
        label.font =  .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.text = "Kategori"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.image = UIImage(systemName: "x.circle")
        imageView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 0,
                                               left: 10,
                                               bottom: 0,
                                               right: 10))
        
        imageView.addSubview(titleLabel)
        titleLabel.anchor(leading: imageView.leadingAnchor,
                          bottom: imageView.bottomAnchor,
                          trailing: imageView.trailingAnchor,
                          padding: UIEdgeInsets(top: 0,
                                                left: 20,
                                                bottom: 20,
                                                right: 20))
        
        imageView.addSubview(categoryLabel)
        categoryLabel.anchor(leading: imageView.leadingAnchor,
                             bottom: titleLabel.topAnchor,
                             trailing: imageView.trailingAnchor,
                             padding: UIEdgeInsets(top: 0,
                                                   left: 20,
                                                   bottom: 20,
                                                   right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
