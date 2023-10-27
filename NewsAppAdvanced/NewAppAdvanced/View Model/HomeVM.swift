//
//  HomeVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 27.10.2023.
//

import Foundation

// MARK: - Protocols
protocol INewsViewModel {
    func getNewsCategory(category: String)
    func getNewsTopHeadLines()
    var  newsOutPut: NewsOutPut? { get }
    func setDelegate(output: NewsOutPut)
    var NewsData: [News] { get set }
}

// MARK: - Home View Model
class HomeVM :INewsViewModel {
    var newsOutPut: NewsOutPut?
    var NewsData: [News] = []
    
    // MARK: - Set Delegate
    func setDelegate(output: NewsOutPut){
        newsOutPut = output
    }


    // MARK: - Get News by Category
    func getNewsCategory(category: String) {
        Task{
            do {
                self.NewsData = try await NetworkManager.shared.getNewsCategoriy(categoryy: category).articles
                self.newsOutPut?.saveDatas(value: self.NewsData)
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
                self.newsOutPut?.saveDatas(value: getNewsResponse.articles)
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
    

