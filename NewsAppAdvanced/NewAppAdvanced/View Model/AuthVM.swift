//
//  LoginVM.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 15.10.2023.
//

import Foundation

//Örnek
class AuthVM{
    // MARK: - Login
    /*
    func login(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(false, error.localizedDescription)
                } else {
                    completion(true, "Giriş başarılı.")
                }
            }
        }
    */
    
    /*
    // MARK: - Register
    func register(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
           Auth.auth().createUser(withEmail: email, password: password) { result, error in
               if let error = error {
                   completion(false, error.localizedDescription)
               } else {
                   completion(true, "Kayıt başarılı.")
               }
           }
       }
    */
    
    /*
    
    // MARK: - ForgotPassword
    func resetPassword(email: String, completion: @escaping (Bool, String) -> Void) {
          guard !email.isEmpty else {
              completion(false, "E-posta alanı boş bırakılamaz.")
              return
          }
          
          Auth.auth().sendPasswordReset(withEmail: email) { error in
              if let error = error {
                  // Şifre sıfırlama işlemi başarısız
                  completion(false, "Şifre sıfırlama hatası: \(error.localizedDescription)")
              } else {
                  // Şifre sıfırlama işlemi başarılı
                  completion(true, "Şifrenizi sıfırlamak için e-posta gönderildi.")
              }
          }
      }
    */
}
