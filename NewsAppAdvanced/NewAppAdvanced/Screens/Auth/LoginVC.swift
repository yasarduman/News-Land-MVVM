//
//  LoginVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 15.10.2023.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI


import UIKit

class LoginVC: UIViewController {
    
    private let HeadLabel            = NewsTitleLabel(textAlignment: .left, fontSize: 20)
    private let emailTextField       = CustomTextField(fieldType: .email)
    private let passwordTextField    = CustomTextField(fieldType: .password)
    private let signInButton         = NewsButton( bgColor:NewsColor.purple1 ,color: NewsColor.purple1, title: "Sign In", fontSize: .big)
    private let infoLabel            = NewsSecondaryTitleLabel(fontSize: 16)
    private let newUserButton        = NewsButton( bgColor:.clear ,color: .label, title: "Sign Up.", fontSize: .small)
    private let forgotPasswordButton = NewsButton( bgColor:.clear ,color: NewsColor.purple1, title: "Forgot password?", fontSize: .small)
    
    private let stackView            = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviewsExt(HeadLabel, emailTextField, passwordTextField, forgotPasswordButton, signInButton,stackView)
        
        configureHeadLabel()
        configureTextField()
        configureForgotPassword()
        configureSignIn()
        configureStackView()
    }
    // MARK: - UI Configuration
    
    private func configureHeadLabel() {
        HeadLabel.text = "Let's sign you in"
        
        HeadLabel.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         //trailing: view.trailingAnchor,
                         padding: .init(top: 80, left: 20, bottom: 0, right: 0)
        )
    }
    
    private func configureTextField() {
        emailTextField.anchor(top: HeadLabel.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 40, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50)
                              
                              
        )
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50)
                              
        )
    }
    
    private func configureForgotPassword(){
        forgotPasswordButton.tintColor = .systemPurple
    
        forgotPasswordButton.anchor(top: passwordTextField.bottomAnchor,
                                    trailing: passwordTextField.trailingAnchor,
                                    padding: .init(top: 10, left: 0, bottom: 0, right: 0)
                                    
        )
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    private func configureSignIn(){
        signInButton.configuration?.cornerStyle = .capsule
        
        signInButton.anchor(top: forgotPasswordButton.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                            size: .init(width: 0, height: 50)
        )
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(newUserButton)
        
        infoLabel.text = "Don't have an account?"
 
        
        stackView.anchor(top: signInButton.bottomAnchor,
                         padding: .init(top: 5, left: 0, bottom: 0, right: 0)
        )
        stackView.centerXInSuperview()
        
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        //Email & Password Validation
        if let email = emailTextField.text, let password = passwordTextField.text {
            if email == "" && password == "" {
                presentNewsAlert(title: "Alert!", message: "Please Enter Email And Password", buttonTitle: "Ok")
            } else {
                if !email.isValidEmail(email: email){
                    presentNewsAlert(title: "Alert!", message: "Invalide Email Address", buttonTitle: "Ok")
                } else if !password.isValidPassword(password: password){

                    if password.count <= 6 {
                        presentNewsAlert(title: "Alert!", message: "Password must be at least 8 characters", buttonTitle: "Ok")
                    }
                    if !password.containsDigits(password){
                        presentNewsAlert(title: "Alert!", message: "Password must contain at least 1 digit", buttonTitle: "Ok")
                    }
                    
                    if !password.containsLowerCase(password){
                        presentNewsAlert(title: "Alert!", message: "Password must contain at least 1 lowercase character", buttonTitle: "Ok")
                    }
                    
                    if !password.containsUpperCase(password){
                        presentNewsAlert(title: "Alert!", message: "Password must contain at least 1 uppercase character", buttonTitle: "Ok")
                    }

                } else {
                    //navigation
                    presentNewsAlert(title: "Alert!", message: "Succsses 🥳", buttonTitle: "Ok")
                }
            }
            
        }

    }
    @objc private func didTapNewUser() {
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}


#Preview(traits: .defaultLayout, body: {
    return LoginVC()
})
#endif
