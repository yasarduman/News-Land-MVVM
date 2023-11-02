//
//  Constants.swift
//  GitNewsAppAdvancedhubFollowers
//
//  Created by Yaşar Duman on 17.10.2023.
//


import UIKit
// MARK: - Color
enum NewsColor {
    static let purple1                    = UIColor(red: 0.49, green: 0.34, blue: 0.76, alpha: 1.00)
    static let purple2                    = UIColor(red: 0.69, green: 0.51, blue: 0.99, alpha: 1.00)
    static let purple3                    = UIColor(red: 0.88, green: 0.81, blue: 1.00, alpha: 1.00)
    static let goldTexxtColor             = UIColor(red: 1.00, green: 0.82, blue: 0.24, alpha: 1.00)
    static let black                      = UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)
    static let TabarbgDark                = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)
    static let TabarbgWhite               = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
}

// MARK: - Mock News
struct MockNews {
    static let json = """
{
      "source": {
        "id": null,
        "name": "Lifehacker.com"
      },
      "author": "Jake Peterson",
      "title": "You Can Now React to iMessages With Emojis and Stickers",
      "description": "Not every text message needs a written response. If someone said something funny, you hit them with a “Haha” reaction. If you’re good with a proposed plan, reaction with a thumbs up sends the same message as, “Sounds good!”Read more...",
      "url": "https://lifehacker.com/you-can-now-react-to-imessages-with-emojis-and-stickers-1850967753",
      "urlToImage": "https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/0720b38aef4d86d48321a600058f79d4.png",
      "publishedAt": "2023-10-27T22:00:00Z",
      "content": "Not every text message needs a written response. If someone said something funny, you hit them with a Haha reaction. If youre good with a proposed plan, reaction with a thumbs up sends the same messa… [+2583 chars]"
    }
""".data(using: .utf8)!
    
    static var mockData: News {
        let news = try! JSONDecoder().decode(News.self, from: json)
        return news
    }
}
