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
        pageControl.numberOfPages = 10
        pageControl.currentPage = 0
        pageControl.tintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .purple
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        let pageControlHeight: CGFloat = 20
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor)
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -pageControlHeight).isActive = true
        
        addSubview(pageControl)
        pageControl.anchor(top: collectionView.bottomAnchor,
                           leading: self.leadingAnchor,
                           trailing: self.trailingAnchor)
        pageControl.heightAnchor.constraint(equalToConstant: pageControlHeight).isActive = true
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    @objc func pageControlValueChanged() {
        let selectedPage = pageControl.currentPage
        let indexPath = IndexPath(item: selectedPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension NewsCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCarouselViewCell.reuseID, for: indexPath) as! NewsCarouselViewCell
        
        return cell
    }
    
    
}

extension NewsCarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension NewsCarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage
    }
}


#Preview {
    UINavigationController(rootViewController: HomeVC())
}
