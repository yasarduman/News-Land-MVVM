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
                let getNewsResponseCategory  = try await NetworkManager.shared.getNewsCategory(category: category)
                let filteredResponse = getNewsResponseCategory.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
                self.delegate?.saveDatas(value: filteredResponse)
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                } else {
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
                let filteredResponse = getNewsResponse.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
                self.delegate?.saveDatas(value: filteredResponse)
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
    

