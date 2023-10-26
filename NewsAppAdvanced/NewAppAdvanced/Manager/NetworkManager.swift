//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit
class NetworkManager {
    
    // MARK: - Properties
    static let shared   = NetworkManager()
    //private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    // MARK: - Initializer
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy    = .iso8601
    }
    
    // MARK: - Fetch Followers
    func getNews() async throws -> NewsModel {
        let endpoint =  "https://newsapi.org/v2/top-headlines?country=tr&apiKey=774527d9f9134f4fbb4032bec7f77007"
        
        guard let url = URL(string: endpoint) else {
            throw NewsError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NewsError.invalidResponse
        }
        
        do {
            return try decoder.decode(NewsModel.self, from: data)
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

