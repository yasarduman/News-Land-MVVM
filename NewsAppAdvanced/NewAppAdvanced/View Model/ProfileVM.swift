//
//  ProfileVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 19.10.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

// MARK: - ViewModel
class ProfileVM {
    let currentUserID = Auth.auth().currentUser!.uid
    
    func fetchUserName(completion: @escaping (String) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let snapshot = snapshot {
                    if let data = snapshot.data() {
                        let userName = data["userName"] as! String
                        completion(userName)
                    }
                }
            }
    }
}
