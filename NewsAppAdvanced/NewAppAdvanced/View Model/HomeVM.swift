//
//  HomeVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 27.10.2023.
//

import Foundation

// MARK: - Protocols
// MARK: - Home View Model
class HomeVM  {
    var delegate: HomeProtocol? = nil

    // MARK: - Get News by Category
    func getNewsCategory(category: String) {
        Task{
            do {
                let getNewsResponseCategory  = try await NetworkManager.shared.getNewsCategoriy(categoryy: category)
                self.delegate?.saveDatas(value: getNewsResponseCategory.articles)
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Get Top Headlines
    func getNewsTopHeadLines() {
        Task{
            do {
                let getNewsResponse = try await NetworkManager.shared.getNews()
                self.delegate?.saveDatas(value: getNewsResponse.articles)
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
    

