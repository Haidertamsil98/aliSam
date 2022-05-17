//
//  ViewController.swift
//  core
//
//  Created by Yogesh Patel on 26/04/18.
//  Copyright © 2018 Yogesh Patel. All rights reserved.
//

import UIKit
import Network



class ViewController: UIViewController, DataPass, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var EditLabel:String! = nil
    
    var shareInstance = SecondViewController()
    public var data: Student?
 
    
    var drID = ""
             func setDrID(){
                 if Services.ServicesInstance.getToken() != "" {
                     drID = Services.ServicesInstance.getToken()
                 }
                 else{
                     drID = APIManager.shareInstance.drID
                 }
             }
             
    
    
    
//    var drID:String! = nil
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return genders.count
        case 2:
            return ages.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return genders[row]
        case 2:
            return ages[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            
            txtCity.text = genders[row]
            if txtCity.text != ""{
                txtCity.backgroundColor = .white
            }
            txtCity.resignFirstResponder()
        case 2:
            age.text = ages[row]
            if age.text != ""{
                age.backgroundColor = .white
            }
            age.resignFirstResponder()
        default:
            return 
        }
    }
        func editData(object:[String:String], i: Int){
            var Student = DatabaseHelper.shareInstance.getAllData()
               Student = Student.filter{
                   ($0.drID?.contains(drID))!
               }
    
               Student[i].name = object["name"]
               Student[i].age = object["age"]
               Student[i].cnic = object["cnic"]
               Student[i].contact = object["contact"]
               Student[i].city = object["city"]
               Student[i].drID = object["drID"]
    
    
               do {
                   try DatabaseHelper.shareInstance.context.save()
               }catch{
                   print("Data is not edited")
    
               }
    }
        
    @IBOutlet weak var edit: UIButton!
    
    
//    var login: loginViewController?
    var arrData = [Student]()
    override func viewDidLoad() {
           super.viewDidLoad()
         setDrID()
//        APIManager.shareInstance.hitthatReq()
    
//        print(drID)
        
//        arrData = DatabaseHelper.shareInstance.getAllData()
//        arrData = arrData.filter{
//            ($0.drID?.contains(drID))!
//            
//        }
        
        
        if EditLabel != nil {
        edit.setTitle(EditLabel, for: [])
        }
           
        picker.delegate = self
        picker.dataSource = self
        
        agePicker.delegate = self
        agePicker.dataSource = self
           
        txtCity?.inputView = picker
        age?.inputView = agePicker
        
        picker.tag = 1
        agePicker.tag = 2
        
        
        txtName?.text = data?.name
        age?.text = data?.age
        txtCnic?.text = data?.cnic
        txtContact?.text = data?.contact
        txtCity?.text = data?.city
        

}
    

    let genders = ["Male", "Female", "Others"]
    let ages = ["0-2", "3-5", "6-13", "14-18", "19-33", "34-48", "49-64", "65-78", "79-98"]
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
        
        
        
        txtName.text = object["name"]
        txtCity.text = object["city"]
        txtContact.text = object["contact"]
        txtCnic.text = object["cnic"]
        age.text = object["age"]
    
        i = index
        isUpdate = isEdit

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        txtName.resignFirstResponder()
        txtCity.resignFirstResponder()
        txtCnic.resignFirstResponder()
        txtContact.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        
        self.view.endEditing(true)
        if txtName.text != ""{
            txtName.backgroundColor = .white
        }
        
        if txtContact.text!.isPhoneNumber{
                   txtContact.backgroundColor = .white
               }
        
        if txtCnic.text!.isValidCnic || txtCnic.text == ""{
        txtCnic.backgroundColor = .white
        }
        
        
        
        
        
        
        if txtCnic.text != "" {
                    if (txtCnic.text?.contains("-"))!{
                        return
                    }
                
                    if txtCnic.text?.count == 13{
                        
                        print(txtCnic.text?.count)
                           let strIndex = txtCnic.text?.index(txtCnic.text!.startIndex, offsetBy: 5)
        //                   let strIndex2 = CNIC.text?.index(CNIC.text!.startIndex, offsetBy: 10)
                        
                       txtCnic.text?.insert("-", at: strIndex!)
        //                CNIC.text?.insert("-", at: strIndex2!)
                        let strIndex3 = txtCnic.text?.index(txtCnic.text!.startIndex, offsetBy: 13)
                        txtCnic.text?.insert("-", at: strIndex3!)
                        
                       txtCnic.backgroundColor = .white
                       }
                    if txtCnic.text!.isValidCnic {
                        txtCnic.backgroundColor = .white
                    }
                }
                
                if txtCnic.text!.isValidCnic {
                                         txtCnic.backgroundColor = .white
                                     }
        
        
        
        
        
        
        
    }
    var i = Int()
    var isUpdate = Bool()
    
    
    var picker =  UIPickerView()
    var agePicker = UIPickerView()
    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet weak var txtCnic: UITextField!
    
    @IBOutlet weak var txtContact: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        
        APIManager.shareInstance.monitor_network()
       
        if txtContact.text!.isPhoneNumber{
            txtContact.backgroundColor = .white
        }
        else{
            txtContact.backgroundColor = .systemPink
            
        }
        
        if txtCnic.text != "" {
        if txtCnic.text!.isValidCnic{
        txtCnic.backgroundColor = .white
        }
        else{
        txtCnic.backgroundColor = .systemPink
        }
           
    }
        
        
         
        
        if txtCity.text == "" || txtName.text == "" || txtContact.text == "" || age.text == ""{
            if txtCity.text == ""{
                txtCity.backgroundColor = .systemPink
            }
            if txtName.text == "" {
                txtName.backgroundColor = .systemPink
            }
            
            if txtContact.text == "" {
                txtContact.backgroundColor = .systemPink
            }
            
            if age.text == "" {
                           age.backgroundColor = .systemPink
                       }
            
            return
        }
            
        
        else{
            
            if txtContact.backgroundColor == .systemPink ||  txtCnic.backgroundColor == .systemPink{
                return
            }
            
           
            
            
        
            
            
            
            
            let dict:[String:String] = ["name":txtName.text!,"city":txtCity.text!, "cnic":txtCnic.text!, "contact":txtContact.text!, "age":age.text!, "drID":drID]
            
            
            
            if isUpdate == true{
                self.editData(object: dict as! [String:String], i: i)
                
                
                let alertView = UIAlertController(title: "Success", message: "Updated Successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                              
                    self.navigationController?.popViewController(animated: true)
                           })
                        alertView.addAction(okAction)
                
                self.present(alertView, animated: true, completion: nil)
            
               
//                secondVC.drID = drID
                
                print("it is true")
                
                let register = updatePatientModel(pat_full_name: txtName.text!, pat_phone: txtContact.text!, pat_cnic: txtCnic.text!, pat_age: age.text!, pat_gender: txtCity.text!, pat_id: drID)
                
                APIManager.shareInstance.updatePatient(login: register)
                    {
                            (isSuccess,str) in
                            if isSuccess{
                                        
                            if str != "Doctor with the provided email or CNIC already exists"{
                                        
                            let alertView = UIAlertController(title: "Success", message: "Registered Successfully", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                                
                    //                            self.progress.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                                                                
                                                                
                                                               
                                        })
                        alertView.addAction(okAction)
                        self.present(alertView, animated: true, completion: nil)
                                            
                                        
                                        }
                                        
                        let alertView = UIAlertController(title: "Failed", message: str, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                            
                    //                        self.progress.stopAnimating()
                                        })
                        alertView.addAction(okAction)
                        self.present(alertView, animated: true, completion: nil)
                                        
                                    }
                    else{
                                    
                    let alertView = UIAlertController(title: "Oops, network issue", message: str, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                            
                    //                        self.progress.stopAnimating()
                        })
                    alertView.addAction(okAction)
                    self.present(alertView, animated: true, completion: nil)
                                    }
                                }

                }
                
            
            else{
 
                DatabaseHelper.shareInstance.save(object: dict)
                
                let alertView = UIAlertController(title: "Success", message: "Patient Saved Successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Next", style: .default, handler: { (alert) in
                            
                
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "recordViewController") as! recordViewController
                    secondVC.Patient = self.txtName.text!
//                secondVC.delegate = self
                self.navigationController?.present(secondVC, animated: true)
                    })
                alertView.addAction(okAction)
                
                
                self.present(alertView, animated: true, completion: nil)
//                secondVC.drID = drID
//                let vc = SecondViewController()
//                shareintance.arrData = DatabaseHelper.shareInstance.getAllData()
//                shareintance.tableView.reloadData()
                
                
                guard let txtName = self.txtName.text else { return }
                guard let txtCity = self.txtCity.text else { return }
                guard let txtContact = self.txtContact.text else { return }
                guard let txtCnic = self.txtCnic.text else { return }
                guard let age = self.age.text else {return}
                          
                           
                let format = DateFormatter()
                format.dateFormat="yyyy-MM-dd"
                let date = format.string(from: Date()) as String
                
                
                
                let register = patientRegister(doctor_fk_id: drID, pat_full_name: txtName, pat_phone: txtContact, pat_cnic: txtCnic, pat_age: age, pat_gender: txtCity, pat_date_added: date)
                
                
//                let monitor = NWPathMonitor()
//                monitor.pathUpdateHandler = { path in
//                if path.status == .satisfied {
                
                
                
                    let monitor = NWPathMonitor()
                    monitor.pathUpdateHandler = { path in
                        if path.status == .satisfied {
                            DispatchQueue.main.async {


                                
                                
                APIManager.shareInstance.patientAPI(login: register)
                                {
                                        (isSuccess,str) in
                                        if isSuccess{
                                                    
                                        if str != "Doctor with the provided email or CNIC already exists"{
                                                    
                                        let alertView = UIAlertController(title: "Success", message: "Registered Successfully", preferredStyle: .alert)
                                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                                            
                                //                            self.progress.stopAnimating()
                                    self.dismiss(animated: true, completion: nil)
                                                                            
                                                                            
                                                                           
                                                    })
                                    alertView.addAction(okAction)
                                    self.present(alertView, animated: true, completion: nil)
                                                        
                                                    
                                                    }
                                                    
                                    let alertView = UIAlertController(title: "Failed", message: str, preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                        
                                //                        self.progress.stopAnimating()
                                                    })
                                    alertView.addAction(okAction)
                                    self.present(alertView, animated: true, completion: nil)
                                                    
                                                }
                                else{
                                                
                                let alertView = UIAlertController(title: "Oops, network issue", message: str, preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                        
                                //                        self.progress.stopAnimating()
                                    })
                                alertView.addAction(okAction)
                                self.present(alertView, animated: true, completion: nil)
                                                }
                                            }

                            }
                            
                        }
                        else{
                             DispatchQueue.main.async {

                                           }
                        }
                    }
                    
                    
                    let queue = DispatchQueue(label: "Network")
                    monitor.start(queue: queue)

                

                            
                

                                }
                        }

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            
            
            txtCity.backgroundColor = .white
            txtName.backgroundColor = .white
            txtContact.backgroundColor = .white
            txtCnic.backgroundColor = .white
            age.backgroundColor = .white

            
           
            
            
            
            
            
            
            
    }
         
    }
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        let updatedString = txtAfterUpdate as String
        //for max length...
        if updatedString.characters.count > 15 {
            return false
        }
        if updatedString.characters.count == 6 && string != "" {
            textField.text = textField.text! + "-"
            return true
        } else if updatedString.characters.count == 14 && string != ""{
            textField.text = textField.text! + "-"
            return true
        }

        return true
    }
    
    
    





private var __maxLengths = [UITextField: Int]()
private var minLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
    
    
    
        @IBInspectable var minLegth: Int {
            get {
                guard let l = minLengths[self] else {
                    return 0
                }
                return l
            }
            set {
                minLengths[self] = newValue
                addTarget(self, action: #selector(fixMin), for: .editingChanged)
            }
        }
        @objc func fixMin(textField: UITextField) {
            if let text = textField.text{
                textField.text = text.safelyLimitedFrom(length: minLegth)
        }
    }
}



extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    func safelyLimitedFrom(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    var isPhoneNumber: Bool {
        do{
            let detector = try NSDataDetector(types:NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 &&
                    res.range.length == self.count && self.count == 11
            } else {
                return false
            }
            
        }
        catch{
            return false
        }
    }
    
    
    
    var isValidCnic: Bool{
        let cnicReg = "^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$"
        let cnicTest = NSPredicate(format: "SELF MATCHES %@", cnicReg)
        return cnicTest.evaluate(with: self)
    }
    
    
}


