//
//  multiColorExtension.swift
//  NewAppAdvanced
//
//  Created by Yaşar Duman on 23.10.2023.
//

import Foundation
import UIKit


extension UILabel {
    func labelColorChange(For givenText: NSString,into color: UIColor, from locationNumber: Int, to length: Int){
    let myString:NSString = givenText
    var myMutableString = NSMutableAttributedString()
    myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: locationNumber,length: length))
    // set label Attribute
        self.attributedText = myMutableString
    }
}

extension UITextView {
    func textViewColorChange(For givenText: NSString,into color: UIColor, from locationNumber: Int, to length: Int){
        let myString:NSString = givenText
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
        
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: locationNumber,length: length))
        // set label Attribute
        self.attributedText = myMutableString
    }
}

extension UIButton {
    func buttonTextColorChange(For givenText: NSString,into color: UIColor, from locationNumber: Int, to length: Int) {
        let myMutableString = NSMutableAttributedString(string: givenText as String);
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: locationNumber,length: length))
        self.setAttributedTitle(myMutableString, for: .normal)
        
    }
    
}


/*
In your viewController

yourLabel.labelColorChange(For: "Hello World", into: UIColor.red, from: 7, to: 3)

yourTextView.textViewColorChange(For: "Hello World", into: UIColor.red, from: 7, to: 3)

yourTextView.buttonTextColorChange(For: "Hello World", into: UIColor.red, from: 7, to: 3)


For More than two colors
yourLabel.labelColorChange(For: yourLabel.labelColorChange(For: "Hello World", into: UIColor.green, from: 7, to: 3), into: UIColor.red, from: 7, to: 3)


*/
