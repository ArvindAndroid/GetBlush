//
//  Utils.swift
//  Imobpay
//
//  Created by Arvind Mehta on 30/05/17.
//  Copyright © 2017 Arvind. All rights reserved.
//

import Foundation
import UIKit


func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func setgradient(view:UIView , firstcolor:String , secondcolor:String , thirdcolor:String){
    let gradient = CAGradientLayer()
    
    gradient.frame = view.bounds
    gradient.colors = [hexStringToUIColor(hex: firstcolor).cgColor, hexStringToUIColor(hex: secondcolor).cgColor,hexStringToUIColor(hex: thirdcolor).cgColor]
    
    view.layer.insertSublayer(gradient, at: 0)
}

func random() -> String {
    let sz: UInt32 = 1000000000
    let ms: UInt64   = UInt64(arc4random_uniform(sz))
    let ls: UInt64   = UInt64(arc4random_uniform(sz))
    let digits: UInt64 = ms * UInt64(sz) + ls
    
    print(String(format:"18 digits: %018llu", digits))
    return String(format:"18 digits: %018llu", digits)
}


func convertDateFormater(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    
    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return ""
    }
    
    dateFormatter.dateFormat = "dd MMM yyyy"
    
    let timeStamp = dateFormatter.string(from: date)
    
    return timeStamp
}




