//
//  DetailVM.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 29.10.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DetailVM {
    let currentUserID = Auth.auth().currentUser!.uid
    
    func addToFavorites(news: News, completion: @escaping (Bool) -> Void) {
        
        let data = [
            "title" : news.title!,
            "description" : news.description!,
            "url" : news.url!,
            "urlToImage" : news.urlToImage!,
            "publishedAt" : news.publishedAt!,
        ] as [String : Any]
        
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(news.url!.hash.description)
            .setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.isFavorited(news: news) { bool in
                    completion(bool)
                }
            }
    }
    
    func removeFromFavorites(news: News, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(news.url!.hash.description)
            .delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.isFavorited(news: news) { bool in
                    completion(bool)
                }
            }
    }
    
    func isFavorited(news: News, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(news.url!.hash.description)
            .getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot {
                    completion(snapshot.exists)
                }
            }
    }
    
}
