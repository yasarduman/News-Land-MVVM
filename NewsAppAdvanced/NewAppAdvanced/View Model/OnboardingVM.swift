//
//  OnboardingVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 24.10.2023.
//

import Foundation
import UIKit

class OnboardingVM {
    let sliderData: [OnboardingItemModel] = [
        OnboardingItemModel(color: NewsColor.purple2, title: "Step into the World of News", text: "Open the doors to the world of news. Discover the latest headlines and stories that pique your interest.", animationName: "a1"),
        OnboardingItemModel(color: NewsColor.purple2, title: "Personalize and Explore", text: "Choose the topics that matter to you and create a personalized news feed. Exploring interesting content has never been easier.", animationName: "a2"),
        OnboardingItemModel(color: NewsColor.purple2, title: "Stay Informed", text: "Don't miss the latest updates. Stay informed about breaking news with instant notifications and always stay up-to-date.", animationName: "a3"),
    ]
}
