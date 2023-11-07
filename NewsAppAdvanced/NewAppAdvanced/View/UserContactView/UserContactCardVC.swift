//
//  UserContactCardVC.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 20.10.2023.
//

import UIKit
import MessageUI

class UserContactCardVC: UIViewController {
    private lazy var conteinerView = UIView()
    private lazy var userImage = UIImageView()
    private lazy var userName  = NewsTitleLabel(textAlignment: .left, fontSize: 20)
    private lazy var userMessage = NewsSecondaryTitleLabel(fontSize: 15)
    private lazy var sendImage = UIImageView()
    private lazy var mailComposer = MFMailComposeViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCotactView()
    }
    // TO-DO -> init ile ala bilirsin boyutunu
    init(userName: String, userEmail: String, userImageName: String){
        super.init(nibName: nil, bundle: nil)
        userImage.image = UIImage(named: userImageName)
        self.userName.text = userName
        mailComposer.setToRecipients([userEmail]) // E-posta alıcısı
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCotactView(){
        view.addSubview(conteinerView)
        conteinerView.addSubview(userName)
        conteinerView.addSubview(userImage)
        conteinerView.addSubview(userMessage)
        conteinerView.addSubview(sendImage)
        conteinerView.backgroundColor = .secondarySystemBackground
        conteinerView.layer.cornerRadius = 10
        
        conteinerView.anchor(top: view.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: view.bottomAnchor,
                             trailing: view.trailingAnchor)
       
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 35
        userImage.anchor(leading: conteinerView.leadingAnchor,
                         padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                         size: .init(width: 70, height: 70)
        )
        userImage.centerYInSuperview()
        
        
        userName.anchor(top: conteinerView.topAnchor,
                        padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        userName.centerXInSuperview()
        
        userMessage.text = "Send you a message"
        userMessage.anchor(top: userName.bottomAnchor,
                           padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
        userMessage.centerXInSuperview()
        
        sendImage.image = UIImage(systemName: "message.badge.filled.fill")
        sendImage.tintColor = NewsColor.purple1
        sendImage.anchor(trailing: conteinerView.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 10),
                         size: .init(width: 35, height: 35)
        )
        sendImage.centerYInSuperview()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
        sendImage.isUserInteractionEnabled = true // UIImageView'ı etkileşimli hale getirin
        sendImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
              
                mailComposer.mailComposeDelegate = self
               
                present(mailComposer, animated: true, completion: nil)
            } else {
                // E-posta gönderme işlevi kullanılamaz durumunda bir hata mesajı görüntüleyebilirsiniz.
               presentNewsAlert(title: "Hata", message: "E-posta gönderme işlevi kullanılamıyor.", buttonTitle: "Ok")
            }
    }
    
//    @objc func sendEmail() {
//        let email = "yasar.duman011@gmail.com"
//        if let url = URL(string: "mailto:\(email)") {
//            UIApplication.shared.open(url)
//        }
//    }

}

extension UserContactCardVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
