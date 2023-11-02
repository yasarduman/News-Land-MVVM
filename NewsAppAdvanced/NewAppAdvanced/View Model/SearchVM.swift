//
//  SearchVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 28.10.2023.
//

import Foundation

// MARK: - Protocols
protocol ISearchViewModel {
    func getNewsSearch(searchTextt: String)
    func getNewsTopHeadLines()
    var  searchOutPut: SearchOutPut? { get }
    func setDelegate(output: SearchOutPut)
    var NewsData: [News] { get set }
}

// MARK: - Search View Model
class SearchVM :ISearchViewModel {
    var searchOutPut: SearchOutPut?
    var NewsData: [News] = []
    
    // MARK: - Set Delegate
    func setDelegate(output: SearchOutPut){
        searchOutPut = output
    }

    // MARK: - Get Top Headlines
    func getNewsTopHeadLines() {
        Task{
            do {
                let response = try await NetworkManager.shared.getNews()
                self.searchOutPut?.saveDatas(value: response)
            } catch {
                if let newsError = error as? NewsError {
                    print("Error Veri Çekerken" + newsError.rawValue)
                }else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Search for News
    func getNewsSearch(searchTextt: String) {
        Task{
            do {
                let response = try await NetworkManager.shared.getNewsSearch(search: searchTextt)
                self.searchOutPut?.saveDatas(value: response)
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
    
