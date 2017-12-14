//
//  RegisterViewController.swift
//  GetBlushh
//
//  Created by Arvind Mehta on 13/12/17.
//  Copyright © 2017 Arvind Mehta. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var bt_male: UIButton!
    @IBOutlet weak var bt_femaie: UIButton!
    @IBOutlet weak var _referralCode: ACFloatingTextfield!
    @IBOutlet weak var _userAniversry: ACFloatingTextfield!
    @IBOutlet weak var _userDOB: ACFloatingTextfield!
    @IBOutlet weak var _email: ACFloatingTextfield!
    @IBOutlet weak var _name: ACFloatingTextfield!
    @IBOutlet weak var _phone: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
         _phone.delegate = self
         _referralCode.delegate = self
         _email.delegate = self
         _name.delegate = self
         _userAniversry.delegate = self
         _userDOB.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func onSubmitClick(_ sender: Any) {
        
        if(validateValues() != ""){
            self.view.makeToast(validateValues())
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func validateValues() -> String {
        var message = ""
        if (_phone.text?.isEmpty)! {
            message = "Please enter valid phone number"
        }
        
        return message
    }
  
}
