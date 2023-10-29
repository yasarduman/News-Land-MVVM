//
//  FavoritesVM.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 29.10.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class FavoritesVM {
    let currentUserID = Auth.auth().currentUser!.uid
    
    func fetchFavorites(completion: @escaping([News]) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                let news = documents.compactMap({try? $0.data(as: News.self)})
                completion(news)
            }
    }
    
    func removeFromFavorites(news: News) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(news.url!.hash.description)
            .delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
}
