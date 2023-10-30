//
//  NewsCarouselView.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 23.10.2023.
//

import UIKit

class NewsCarouselView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NewsCarouselViewCell.self,
                                forCellWithReuseIdentifier: NewsCarouselViewCell.reuseID)
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0
        pageControl.currentPage = 0
        pageControl.tintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .purple
        return pageControl
    }()
    
    //MARK: - Variables
    var delegate: HomeProtocol? = nil
    
    var news: [News]? = nil {
        willSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            pageControl.numberOfPages = newValue!.count
        }
    }
    
    let pageControlHeight: CGFloat = 20
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helper Functions
    
    private func configureUI() {
        configureCollectionView()
        configurePageControl()
    }
    
    private func configureCollectionView() {
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor)
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -pageControlHeight).isActive = true
    }
    
    private func configurePageControl() {
        addSubview(pageControl)
        pageControl.anchor(top: collectionView.bottomAnchor,
                           leading: self.leadingAnchor,
                           trailing: self.trailingAnchor)
        pageControl.heightAnchor.constraint(equalToConstant: pageControlHeight).isActive = true
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    @objc func pageControlValueChanged() {
        let selectedPage = pageControl.currentPage
        let indexPath = IndexPath(item: selectedPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension NewsCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCarouselViewCell.reuseID, for: indexPath) as! NewsCarouselViewCell
        
        if let news = news {
            let news = news[indexPath.row]
            
            if let url = news.urlToImage {
                Task {
                    cell.imageView.image = await NetworkManager.shared.downloadImage(from: url)
                }
            }
            
            if let source = news.source {
                if let sourceName = source.name {
                    cell.categoryLabel.text = sourceName
                }
            }
            
            if let title = news.title {
                cell.titleLabel.text = title
            }
            
            
        }
        
        
        return cell
    }
    
    
}

extension NewsCarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = news![indexPath.row]
        
        delegate?.pushDetail(value: news)
    }
}

extension NewsCarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage
    }
}
