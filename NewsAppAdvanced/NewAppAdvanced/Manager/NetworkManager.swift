//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//


import UIKit

class NetworkManager {
    // Erislam Nurluyol Api Key 21ac99ce70374ca2a3cdfbebeebd044c
    // Yaşar Duman Api Key 774527d9f9134f4fbb4032bec7f77007
    
    // MARK: - Properties
    static let shared   = NetworkManager()
    private let baseURL = "https://newsapi.org/v2/"
    private let topHeadlinesEndPoint = "top-headlines?country=us"
    private let categoryEndPoint = "&category="
    private let searchEndPoint = "everything?q="
    private let API_KEY = "&apiKey=774527d9f9134f4fbb4032bec7f77007"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    // MARK: - Initializer
    private init() {
        decoder.keyDecodingStrategy     = .convertFromSnakeCase
        decoder.dateDecodingStrategy    = .iso8601
    }
    
    // MARK: - Fetch News
    func getNews() async throws -> [News] {
        let endpoint =  baseURL + topHeadlinesEndPoint + API_KEY
        
        guard let url = URL(string: endpoint) else {
            throw NewsError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NewsError.invalidResponse
        }
        
        do {
            let response = try decoder.decode(NewsModel.self, from: data)
            let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
            return filteredResponse
        } catch {
            throw NewsError.invalidData
        }
    }
    
    // MARK: - Fetch News Category
    func getNewsCategory(category: String) async throws -> [News] {
        let endpoint =  baseURL + topHeadlinesEndPoint + categoryEndPoint + "\(category)" + API_KEY
        
        guard let url = URL(string: endpoint) else {
            throw NewsError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NewsError.invalidResponse
        }
        
        do {
            let response = try decoder.decode(NewsModel.self, from: data)
            let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
            return filteredResponse
        } catch {
            throw NewsError.invalidData
        }
    }
    
    // MARK: - Fetch News Category
    func getNewsSearch(search: String) async throws -> [News] {
        let endpoint = baseURL + searchEndPoint + "\(search)" + API_KEY
        
        guard let url = URL(string: endpoint) else {
            throw NewsError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NewsError.invalidResponse
        }
        
        do {
            let response = try decoder.decode(NewsModel.self, from: data)
            let filteredResponse = response.articles.filter({ $0.title != nil && $0.description != nil && $0.urlToImage != nil })
            return filteredResponse
        } catch {
            throw NewsError.invalidData
        }
    }
    
    // MARK: - Download Image
    func downloadImage(from urlString: String) async ->  UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
