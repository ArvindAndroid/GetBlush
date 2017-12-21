//
//  Utils.swift
//  Imobpay
//
//  Created by Arvind Mehta on 30/05/17.
//  Copyright © 2017 Arvind. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


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

func renderUIView(radius:CGFloat,borderWidth:CGFloat,borderColor:UIColor,view:UIView)  {
    view.clipsToBounds = true
    view.layer.masksToBounds = false
    view.layer.cornerRadius = radius
    view.layer.borderWidth = borderWidth
    view.layer.borderColor =  borderColor.cgColor
}

func shodowOnUIObject(object:UIView)  {
    
    UIBezierPath.init(cgPath: object.bounds as! CGPath)
    object.layer.masksToBounds = false
    object.layer.shadowColor = UIColor.black as! CGColor
    object.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
    object.layer.shadowOpacity = 0.5
    object.layer.cornerRadius = 1.0
    
}


func isLocationEnabled() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            print("No access")
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            return true
        }
    } else {
        return false
      
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}




