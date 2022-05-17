//
//  RegisterViewController.swift
//  core
//
//  Created by Apple on 27/07/2021.
//  Copyright © 2021 Yogesh Patel. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
        
    }
    
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        gender.text = genders[row]
        gender.resignFirstResponder()
    }
    
    
    
    
    @IBAction func anotherLogin(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
 let genders = ["Male", "Female", "Others"]
    
    @IBOutlet weak var FullName: UITextField!
        
    @IBOutlet weak var HospitalName: UITextField!

    @IBOutlet weak var EmailAddress: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var MobileNumber: UITextField!
    
    @IBOutlet weak var CNIC: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    
    var agePicker = UIPickerView()
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
       
        
        if FullName.text != ""{
            FullName.backgroundColor = .white
        }
        
        if EmailAddress.text!.isValidEmail{
                   EmailAddress.backgroundColor = .white
               }
        
        if HospitalName.text != ""{
                   HospitalName.backgroundColor = .white
               }
        
        if password.text != ""{
                   password.backgroundColor = .white
               }
        
        if gender.text != ""{
                   gender.backgroundColor = .white
               }
        
        if MobileNumber.text!.isPhoneNumber  {
                          MobileNumber.backgroundColor = .white
                      }
        if CNIC.text != "" {
            if (CNIC.text?.contains("-"))!{
                return
            }
        
            if CNIC.text?.count == 13{
                
                print(CNIC.text?.count)
                   let strIndex = CNIC.text?.index(CNIC.text!.startIndex, offsetBy: 5)
//                   let strIndex2 = CNIC.text?.index(CNIC.text!.startIndex, offsetBy: 10)
                
                CNIC.text?.insert("-", at: strIndex!)
//                CNIC.text?.insert("-", at: strIndex2!)
                let strIndex3 = CNIC.text?.index(CNIC.text!.startIndex, offsetBy: 13)
                CNIC.text?.insert("-", at: strIndex3!)
                
                CNIC.backgroundColor = .white
               }
            if CNIC.text!.isValidCnic {
                CNIC.backgroundColor = .white
            }
        }
        
        if CNIC.text!.isValidCnic {
                                 CNIC.backgroundColor = .white
                             }
        
       
        
    }
    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        agePicker.delegate = self
        agePicker.dataSource = self
        
        gender.inputView = agePicker
        
    }
    
    

    @IBAction func register(_ sender: Any) {
        
        
        
    if EmailAddress.text != "" {
           if EmailAddress.text!.isValidEmail{
           EmailAddress.backgroundColor = .white
           }
           else{
           EmailAddress.backgroundColor = .systemPink
            return
           }
         
              
        }
        
        
        if MobileNumber.text != "" {
            if MobileNumber.text!.isPhoneNumber{
            MobileNumber.backgroundColor = .white
                  }
            else{
                MobileNumber.backgroundColor = .systemPink
                return
                }
                   
            }
        
        
        if CNIC.text != "" {
                  if CNIC.text!.isValidCnic{
                  CNIC.backgroundColor = .white
                  }
                  else{
                  CNIC.backgroundColor = .systemPink
                  return
                  }
            }
        
        
        if FullName.text == "" || HospitalName.text == "" || password.text == "" || MobileNumber.text == "" || CNIC.text == "" || gender.text == "" || EmailAddress.text == ""{
                   if FullName.text == ""{
                       FullName.backgroundColor = .systemPink
                   }
                   if HospitalName.text == "" {
                       HospitalName.backgroundColor = .systemPink
                   }
                   
                   if password.text == "" {
                       password.backgroundColor = .systemPink
                   }
                   
                   if CNIC.text == "" {
                                  CNIC.backgroundColor = .systemPink
                              }
                  if gender.text == "" {
                        gender.backgroundColor = .systemPink
                        }
            
                if MobileNumber.text == "" {
                        MobileNumber.backgroundColor = .systemPink
                        }
            
            if  EmailAddress.text == "" {
            EmailAddress .backgroundColor = .systemPink
            }
                   
                   return
               }
        
        progress.startAnimating()
        
        guard let fname = self.FullName.text else { return }
        guard let hname = self.HospitalName.text else { return }
        guard let email = self.EmailAddress.text else { return }
        guard let password = self.password.text else { return }
        guard let MobileNumber = self.MobileNumber.text else {return}
        guard let Cnic = self.CNIC.text else { return }
        guard let Gender = self.gender.text else { return }
        
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd"
        let date = format.string(from: Date()) as String
        
        
        
        let register = Register(doc_full_name: fname, hospital_name: hname, doc_email: email, doc_phone: MobileNumber, doc_cnic: Cnic, doc_gender: Gender, user_name: fname, password: password, doc_date_added: date )
        
        APIManager.shareInstance.callingRegisterAPI(register: register)
        {
            (isSuccess,str) in
            if isSuccess{
                
                if str != "Doctor with the provided email or CNIC already exists"{
                
                    let alertView = UIAlertController(title: "Success", message: "Registered Successfully", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                        
                        self.progress.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                                        
                                        
                                       
                })
                                    alertView.addAction(okAction)
                                    self.present(alertView, animated: true, completion: nil)
                    
                
                }
                
               let alertView = UIAlertController(title: "Failed", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
                    self.progress.stopAnimating()
                })
                 alertView.addAction(okAction)
                 self.present(alertView, animated: true, completion: nil)
                
            }
            else{
            
                let alertView = UIAlertController(title: "Oops, network issue", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
                    self.progress.stopAnimating()
                })
                 alertView.addAction(okAction)
                 self.present(alertView, animated: true, completion: nil)
            }
        }
                
    }
   
    
}




//Regular expression for email validation
extension String
{
  
    var isValidEmail: Bool{
        let cnicReg = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let cnicTest = NSPredicate(format: "SELF MATCHES %@", cnicReg)
        return cnicTest.evaluate(with: self)
    }
    
    
    
    
    
  
    
    
}

