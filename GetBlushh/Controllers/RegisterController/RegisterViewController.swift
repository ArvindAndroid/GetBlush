//
//  RegisterViewController.swift
//  GetBlushh
//
//  Created by Arvind Mehta on 13/12/17.
//  Copyright © 2017 Arvind Mehta. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var btMale: UIButton!
    @IBOutlet weak var btFemale: UIButton!
    @IBOutlet weak var bt_male: UIButton!
    @IBOutlet weak var bt_femaie: UIButton!
    @IBOutlet weak var _referralCode: ACFloatingTextfield!
    @IBOutlet weak var _userAniversry: ACFloatingTextfield!
    @IBOutlet weak var _userDOB: ACFloatingTextfield!
    @IBOutlet weak var _email: ACFloatingTextfield!
    @IBOutlet weak var _name: ACFloatingTextfield!
    @IBOutlet weak var _phone: ACFloatingTextfield!
      let datePicker: UIDatePicker = UIDatePicker()
    var coumpoundStatus:String = "F"
    var isAniversryEdit:Bool = false
    
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == _userDOB {
            datePicker.timeZone = NSTimeZone.local
            datePicker.backgroundColor = UIColor.white
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let done = UIBarButtonItem(barButtonSystemItem:.done,target:nil,action:#selector(datePickerValueChanged))
            toolbar.setItems([done], animated: false)
            _userDOB.inputAccessoryView = toolbar
            _userDOB.inputView = datePicker
            datePicker.datePickerMode = .date
            isAniversryEdit = false
        }else if textField == _userAniversry {
            datePicker.timeZone = NSTimeZone.local
            datePicker.backgroundColor = UIColor.white
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let done = UIBarButtonItem(barButtonSystemItem:.done,target:nil,action:#selector(datePickerValueChanged))
            toolbar.setItems([done], animated: false)
            _userAniversry.inputAccessoryView = toolbar
            _userAniversry.inputView = datePicker
            datePicker.datePickerMode = .date
            isAniversryEdit = true
        }
    }
  
    @IBAction func onAniversaryEditBegin(_ sender: Any) {

    }

    @IBAction func onSubmitClick(_ sender: Any) {
        
        if(validateValues() != ""){
            self.view.makeToast(validateValues())
        }else{
            submitRequest(phone: _phone.text!, name: _name.text!, email: _email.text!, dob: _userDOB.text!, aniversary: _userAniversry.text!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCheckToFemale() {
        btFemale.setImage(UIImage(named: "checked"), for: UIControlState.normal)
        btMale.setImage(UIImage(named: "uncheck"), for: UIControlState.normal)
        coumpoundStatus = "F"
    }
    func setCheckToMale() {
        btMale.setImage(UIImage(named: "checked"), for: UIControlState.normal)
        btFemale.setImage(UIImage(named: "uncheck"), for: UIControlState.normal)
         coumpoundStatus = "M"
    }
    

    func validateValues() -> String {
        var message = ""
        if (_phone.text?.isEmpty)! {
            message = "Please enter valid phone number"
        } else if (_name.text?.isEmpty)! {
            message = "Please enter your name"
        }else if (_email.text?.isEmpty)! {
            message = "Please enter your mail"
        }else if (_userDOB.text?.isEmpty)! {
            message = "Please enter your Date of Birth"
        }else if (_userAniversry.text?.isEmpty)! {
             message = "Please enter your Aniversary"
        }
        
        return message
    }
    
    @IBAction func onMaleCheckListner(_ sender: Any) {
        setCheckToMale()
    }
    @IBAction func onFemalCkeckListner(_ sender: Any) {
        setCheckToFemale()
    }
    func submitRequest(phone:String,name:String,email:String,dob:String,aniversary:String)  {
        let parameter = [
            "name": name,
            "countryCode": "91",
            "mobileNo":phone,
            "email":email,
            "dob":dob,
            "anniversary_date":aniversary,
            "referral_code":"",
            "gender": coumpoundStatus,
            "device_token":"xyzIOS",
            "device_type":UIDevice.current.modelName,
            "image":"notImage"]
    
        executePOST(view: self.view, path: Constants.LIVEURL+"userRegistration", parameter: parameter){response in
            print(response)
            
        }
    }
  
    //TODO Pikers Call back Methods for Date and Aniversary
    @objc func datePickerValueChanged(){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate: String = dateFormatter.string(from: datePicker.date)
        
        print("Selected value \(selectedDate)")
        if(selectedDate != ""){
            if(isAniversryEdit){
                 _userAniversry.text = selectedDate
            }else{
                 _userDOB.text = selectedDate
            }
           
        }else{
            self.view.makeToast("Not able to fetch date! please try again")
        }
        self.view.endEditing(true)
    }
    
 
}
