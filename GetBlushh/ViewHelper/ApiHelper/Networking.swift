//
//  Networking.swift
//  Imobpay
//
//  Created by Arvind Mehta on 30/05/17.
//  Copyright © 2017 Arvind. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON



func executePOST(view:UIView,path:String, parameter:Parameters , completion: @escaping (JSON) -> ()) {
    
    view.makeToastActivity(.center)
 
    //    let headers = [
    //         ]
    
    Alamofire.request(path,method: .post, parameters: parameter, encoding: URLEncoding.default,headers: nil).validate().responseJSON { response in
        view.hideToastActivity()
        switch response.result {
        case .success:
            do {
                let jsonData = try JSON(data: response.data!)
                completion(jsonData)
            }catch{
                
            }
            
        case .failure:
            do {
                try completion(JSON(data: NSData() as Data))
            }catch{
                
            }
            
        }
    }
}



func executeGET(view:UIView,path:String , completion: @escaping (JSON) -> ()) {
    view.makeToastActivity(.center)
    
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded" ]
    print(Constants.LIVEURL+path)
    print(headers)
    Alamofire.request(Constants.LIVEURL+path,method: .get,  encoding: JSONEncoding.default,headers: headers).validate().responseJSON { response in
        view.hideToastActivity()
        switch response.result {
        case .success:
            view.hideToastActivity()
            do {
                let jsonData = try JSON(data: response.data!)
                completion(jsonData)
            }catch{
                
            }
            
            
        case .failure:
            view.hideToastActivity()
            do {
                try completion(JSON(data: NSData() as Data))
            }catch{
                
            }
        }
    }
    
}

func executeGETHEADER(view:UIView,path:String , completion: @escaping (JSON) -> ()) {
    
    view.makeToastActivity(.center)
    print(getSharedPrefrance(key: ""))
    let headers = [
        
        "x-access-token": getSharedPrefrance(key:Constants.USER_TOKEN),
        "Content-Type": "application/x-www-form-urlencoded" ]
    Alamofire.request(Constants.LIVEURL+path,method: .get,  encoding: JSONEncoding.default,headers: headers).validate().responseJSON { response in
        switch response.result {
        case .success:
            view.hideToastActivity()
            do {
                let jsonData = try JSON(data: response.data!)
                completion(jsonData)
            }catch{
                
            }
            
        case .failure:
            view.hideToastActivity()
            do {
                try completion(JSON(data: NSData() as Data))
            }catch{
                
            }
        }
    }
    
}


func executePOSTWITHHEADER(view:UIView,path:String, parameter:Parameters , completion: @escaping (JSON) -> ()) {
    
    view.makeToastActivity(.center)
    print(path)
    print(path)
    let headers = [
        
        "x-access-token": getSharedPrefrance(key:Constants.USER_SECERET),
        "Content-Type": "application/x-www-form-urlencoded" ]
    Alamofire.request(path,method: .post, parameters: parameter, encoding: URLEncoding.default,headers: headers).validate().responseJSON { response in
        view.hideToastActivity()
        switch response.result {
        case .success:
            do {
                let jsonData = try JSON(data: response.data!)
                completion(jsonData)
            }catch{
                
            }
            
        case .failure:
            do {
                try completion(JSON(data: NSData() as Data))
            }catch{
                
            }
            
        }
    }
}









