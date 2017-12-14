//
//  LoginViewController.swift
//  GetBlushh
//
//  Created by Arvind Mehta on 13/12/17.
//  Copyright © 2017 Arvind Mehta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{

   
    @IBOutlet weak var avoidUsin: UIView!
    @IBOutlet weak var _phone: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         _phone.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func onSaveClick(_ sender: Any) {
        
        if(validateValues() != ""){
            self.view.makeToast(validateValues())
        }else{
            submitRequest(phone:_phone.text!)
        }
    }
    
    func validateValues() -> String {
        var message = ""
        if (_phone.text?.isEmpty)! {
            message = "Please enter valid phone number"
        }
        
        return message
    }
    // Optional
    // These delegate methods can be used so that test fields that are hidden by the keyboard are shown when they are focused
   
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if textField == self._phone {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func submitRequest(phone:String) {
        let parameter = [
            "countryCode": "91",
            "mobileNo": phone]
        executePOST(view: self.view,path: Constants.LIVEURL+"userExistsOrNotApi", parameter: parameter){ response in
            print(response)
            var code =  response["status"].stringValue
            print(code)
            if(code == "200"){
                for item in response["data"].arrayValue {
                  
                }
            }else{
                self.view.makeToast("\(response["message"])")
            }
        }
    }
}
