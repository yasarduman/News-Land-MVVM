//
//  RegisterVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 18.10.2023.
//
#if canImport(SwiftUI) && DEBUG
import SwiftUI

import UIKit

class RegisterVC: UIViewController {

    private let HeadLabel            = NewsTitleLabel(textAlignment: .left, fontSize: 20)
    private let userNameTextField    = CustomTextField(fieldType: .username)
    private let emailTextField       = CustomTextField(fieldType: .email)
    private let passwordTextField    = CustomTextField(fieldType: .password)
    private let repasswordTextField  = CustomTextField(fieldType: .password)
    private let signUpButton         = NewsButton( bgColor:NewsColor.purple1 ,color: NewsColor.purple1, title: "Sign Up", fontSize: .big)
    private let infoLabel            = NewsSecondaryTitleLabel(fontSize: 16)
    private let signInButton         = NewsButton( bgColor:.clear ,color: .label, title: "Sign In.", fontSize: .small)
    
    private let stackView            = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureHeadLabel()
        configureTextField()
        configureSignUp()
        configureStackView()
    }
    
    // MARK: - UI Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.addSubviewsExt(HeadLabel, userNameTextField, emailTextField, passwordTextField, repasswordTextField, signUpButton, signInButton, stackView)
    }
    
    private func configureHeadLabel() {
        HeadLabel.text = "Create an account"
        
        HeadLabel.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         //trailing: view.trailingAnchor,
                         padding: .init(top: 80, left: 20, bottom: 0, right: 0)
        )
    }
    
    private func configureTextField() {
        userNameTextField.anchor(top: HeadLabel.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 40, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50)
                              
                              
        )
        
        emailTextField.anchor(top: userNameTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50)
                              
                              
        )

        
        passwordTextField.anchor(top: emailTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50)
                              
        )
        
        repasswordTextField.placeholder = "Repassword"
           
        repasswordTextField.anchor(top: passwordTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50)
                              
        )

    }
    
    private func configureSignUp(){
        signUpButton.configuration?.cornerStyle = .capsule

        signUpButton.anchor(top: repasswordTextField.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                            size: .init(width: 0, height: 50)
        )
        
       
    }
    
  

    private func configureStackView() {
        stackView.axis          = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(signInButton)
        
        infoLabel.text = "Already have an account?"

        stackView.anchor(top: signUpButton.bottomAnchor,
                         padding: .init(top: 5, left: 0, bottom: 0, right: 0)
        )
        
        stackView.centerXInSuperview()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }
    
    // MARK: - Action
    @objc private func didTapSignUp() {
        //Email & Password Validation
        if let email = emailTextField.text, let password = passwordTextField.text, let rePassword = repasswordTextField.text {
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
                    
                    if password != rePassword {
                        presentNewsAlert(title: "Alert!", message: "Password and password repeat are not the same", buttonTitle: "Ok")
                    }

                } else {
                    //navigation
                    presentNewsAlert(title: "Alert!", message: "Succsses 🥳", buttonTitle: "Ok")
                }
            }
            
        }
    }
    
    @objc private func didTapSignIn() {

        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}

#Preview(traits: .defaultLayout, body: {
    return RegisterVC()
})
#endif
