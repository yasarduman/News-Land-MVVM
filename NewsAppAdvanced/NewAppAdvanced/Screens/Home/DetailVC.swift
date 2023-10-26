    import UIKit

    class DetailVC: UIViewController, UIScrollViewDelegate {
        // MARK: - Properties
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.contentInsetAdjustmentBehavior = .never
            return scrollView
        }()
        
        let scrollViewContainer: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            return view
        }()
        
        let imageView = UIImageView()
        
        // MARK: - Bookmark and Back Button
        let bookmarkImageContainer = UIView()
        let bookmarkImage = UIImageView(image: UIImage(systemName: "bookmark"))
        
        let backImageContainer = UIView()
        let backImage = UIImageView(image: UIImage(systemName: "chevron.compact.left"))
        
        let containetViewDes : UIView = {
            let view = UIView()
            
            view.clipsToBounds = true
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner
            
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.tertiarySystemGroupedBackground.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: -90) // Y ekseninde negatif bir değer vererek shadow'ı yukarıda yerleştirin
            
            view.layer.shadowOpacity = 0.7
            view.layer.shadowRadius = 90
            
            return view
        }()
        let imageTitleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 30, fontWeight: .bold)
        let dateLabel = NewsSecondaryTitleLabel(fontSize: 20)
        let titleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 25, fontWeight: .bold)
        let desciriptionLabel = NewsSecondaryTitleLabel(fontSize: 20)
        

        // MARK: - View Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            imageTitleLabel.text = "Dikat Çekici Başlık Ve tarih Bölümü"
            dateLabel.text = "16 Oct 2023"
            titleLabel.text = "Haber Başlık Bölümü"
            desciriptionLabel.text = "Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya  Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kaya  doğru  buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kayacak.Uzun bir açıklama buraya gelecek. Scroll yaparken metin aşağı doğru kaya  doğru "
            
            configureViewController()
            configureScrollView()
            configureScrollViewContainer()
            configureImageView()
            configureContainetViewDes()
            configureDesciriptionText()
            configureVackAndBookmark()
            
            imageTitleLabel.labelColorChange(For: imageTitleLabel.text! as NSString , into: NewsColor.purple1, from: 5, to: 14)
            titleLabel.labelColorChange(For: titleLabel.text! as NSString , into: NewsColor.purple1, from: 0, to: 5)
            imageTitleLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
            titleLabel.font = UIFont(name: "Helvetica-Bold", size: 20)


        }
        // MARK: - UI Configuration
        func configureViewController() {
            view.backgroundColor = .systemBackground
            self.navigationItem.setHidesBackButton(true, animated: true)
            
            scrollView.delegate = self
            let isDarkModeOn = UserDefaults.standard.bool(forKey: "DarkMode")
            if isDarkModeOn {
                containetViewDes.layer.shadowColor = UIColor.white.cgColor
            } else {
                containetViewDes.layer.shadowColor = UIColor.black.cgColor
            }
        }
        
        func configureScrollView() {
            view.addSubview(scrollView)
            
            scrollView.anchor(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor
            )
        }
        
        func configureScrollViewContainer() {
            scrollViewContainer.backgroundColor = .systemBackground
            
            scrollView.addSubview(scrollViewContainer)
            scrollViewContainer.addArrangedSubview(imageView)
            scrollViewContainer.addArrangedSubview(containetViewDes)
            
            scrollViewContainer.anchor(top: scrollView.topAnchor,
                                       leading: scrollView.leadingAnchor,
                                       bottom: scrollView.bottomAnchor,
                                       trailing: scrollView.trailingAnchor
            )
            
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
        
        func configureImageView(){
            imageView.image = UIImage(named: "userName")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
         
            
            imageView.addSubview(bookmarkImageContainer)
            imageView.addSubview(backImageContainer)
            imageView.addSubview(imageTitleLabel)
            imageView.addSubview(dateLabel)
            bookmarkImageContainer.addSubview(bookmarkImage)
            backImageContainer.addSubview(backImage)
        
       
            imageView.anchor(top: scrollViewContainer.topAnchor,
                             leading: scrollViewContainer.leadingAnchor,
                             trailing: scrollViewContainer.trailingAnchor,
                             size: .init(width: 0, height: 415)
            )
            imageTitleLabel.numberOfLines = 0
            imageTitleLabel.anchor(leading: imageView.leadingAnchor,
                                   bottom: imageView.bottomAnchor,
                                   trailing: imageView.trailingAnchor,
                                   padding: .init(top: 0, left: 30, bottom: 50, right: 30)
            )
            
            dateLabel.anchor(leading: imageTitleLabel.leadingAnchor,
                                   bottom: imageTitleLabel.topAnchor,
                                   trailing: imageTitleLabel.trailingAnchor,
                                   padding: .init(top: 0, left: 0, bottom: 10, right: 0)
            )
            
        }
        
        func configureContainetViewDes() {
            containetViewDes.backgroundColor = .tertiarySystemGroupedBackground
            
            containetViewDes.addSubview(titleLabel)
            containetViewDes.addSubview(desciriptionLabel)
            
            containetViewDes.anchor(top: imageView.bottomAnchor,
                                    leading: scrollViewContainer.leadingAnchor,
                                    bottom: scrollViewContainer.bottomAnchor,
                                    trailing: scrollViewContainer.trailingAnchor,
                                    padding: .init(top: -30, left: 0, bottom: 0, right: 0)
            )
            
            
            print(desciriptionLabel.text?.count as Any)
            if desciriptionLabel.text!.count > 500 {
                desciriptionLabel.bottomAnchor.constraint(equalTo: containetViewDes.bottomAnchor, constant: -40).isActive = true
            } else {
                containetViewDes.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -370).isActive = true
            }
        }
        
        func configureDesciriptionText(){
            
               titleLabel.anchor(top: containetViewDes.topAnchor,
                                 leading: containetViewDes.leadingAnchor,
                                 
                                 trailing: containetViewDes.trailingAnchor,
                                 padding: .init(top: 30, left: 30, bottom: 0, right: 30)
               )
               desciriptionLabel.anchor(top: titleLabel.bottomAnchor,
                                        leading: containetViewDes.leadingAnchor,
                                        //bottom: containetViewDes.bottomAnchor,
                                        trailing: containetViewDes.trailingAnchor,
                                        padding: .init(top: 15, left: 30, bottom: 10, right: 30)
               )
               
               
               desciriptionLabel.numberOfLines = 0
               
        }
        
        func configureVackAndBookmark(){

            bookmarkImageContainer.anchor(top: imageView.topAnchor,
                                          trailing: imageView.trailingAnchor,
                                          padding: .init(top: 50, left: 0, bottom: 0, right: 20),
                                          size: .init(width: 50, height: 50)
            )
            bookmarkImageContainer.backgroundColor = NewsColor.purple1
            bookmarkImageContainer.layer.cornerRadius = 15
            bookmarkImage.anchor(
                size: .init(width: 25, height: 25)
            )
            bookmarkImage.tintColor = .white
            bookmarkImage.centerInSuperview()
            
            
            backImageContainer.anchor(top: imageView.topAnchor,
                                      leading: imageView.leadingAnchor,
                                      padding: .init(top: 50, left: 20, bottom: 0, right: 0),
                                      size: .init(width: 50, height: 50)
            )
            backImageContainer.backgroundColor = NewsColor.backButtonColor
            backImageContainer.layer.cornerRadius = 15
            backImage.anchor(
                size: .init(width: 25, height: 25)
            )
            backImage.tintColor = .white
            backImage.centerInSuperview()
            
            
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let yOffset = scrollView.contentOffset.y
            //print(yOffset)
            let minImageHeight: CGFloat = 60 // Resmin altından başlayan kaybolma efekti
            let maxImageHeight: CGFloat = 400 // Resmin başladığı yükseklik
            let imageAlpha = 1.0 - (yOffset / (maxImageHeight - minImageHeight))
            //imageView.anchor(size: .init(width: 400 - yOffset, height: 400 - yOffset))
            imageView.alpha = imageAlpha
        }
        
        
        
    }

 

    #Preview{
        DetailVC()
    }
