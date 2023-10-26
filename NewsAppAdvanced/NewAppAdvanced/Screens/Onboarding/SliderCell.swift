//
//  SliderCell.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 23.10.2023.
//

import UIKit
import Lottie

class SliderCell: UICollectionViewCell {
    // MARK: - Views
    lazy var titleLabel = UILabel()
    lazy var textLabel = UILabel()
    private var lottieView = LottieAnimationView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lottieView)
        setSlider()
    }
    
    // MARK: - UI Setup
    private func setSlider(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        textLabel.textAlignment = .center
        
        
        titleLabel.textColor = NewsColor.goldTexxtColor
        titleLabel.numberOfLines = 0
           
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
      
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Animation Setup
    func animationSetup(animationName: String){
        contentView.addSubview(lottieView)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.animation = LottieAnimation.named(animationName)
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        
        lottieView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160).isActive = true
        lottieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        lottieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        lottieView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        lottieView.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview{
    OnboardingVC()
}
