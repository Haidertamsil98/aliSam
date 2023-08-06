//
//  diagnosisViewController.swift
//  core
//
//  Created by Apple on 13/06/2021.
//  Copyright © 2021 HaiderTamsil. All rights reserved.
//

import UIKit


class Country {
    var country: String
    var cities: [String]
    
    
    init(country:String, cities:[String]  ){
        self.cities = cities
        self.country = country
        
    }
}

class diagnosisViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var base64:String!=nil
    var position:String!=nil
    var location:String!=nil
    var filePath: String!=nil
    var Diagnosis: String!=nil
    var Patient: String!=nil
    
    
    var i = Int()
    var isUpdate = Bool()
       
    
    public var data: Audio?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1{
        return 2
            
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1{
            if component == 0 {
                return countries.count
            }
        else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            return countries[selectedCountry].cities.count
        }
        }
        
        if pickerView.tag == 2 {
            return CardiacData.count
        }
        else{
            return ExtraData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
        pickerView.reloadComponent(1)
        
        let selectedCountry = pickerView.selectedRow(inComponent: 0)
        let selectedCity = pickerView.selectedRow(inComponent: 1)
        let country = countries[selectedCountry].country
        let city = countries[selectedCountry].cities[selectedCity]
        
        label.isHidden = false
        more.isHidden = false
        label.text = "Disease: \(country)\nMore:\(city)"
        more.text = city
        }
        
        if pickerView.tag == 2 {
            label.isHidden = false
            more.isHidden = true
            label.text = CardiacData[row]
        }
        
        if pickerView.tag == 3 {
            label.isHidden = false
            more.isHidden = true
            label.text = ExtraData[row]
        }
 }
  
    
    
    @IBOutlet weak var comments: UITextField!
 
    @IBOutlet weak var on_off: UISwitch!
    @IBAction func ON_Button(_ sender: Any) {
        
        label.isHidden = false
        more.isHidden = true
        
        label.text = "Normal"
        
        if on_off.isOn == false{
            label.text = ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
        if component == 0 {
            return countries[row].country
               }
               else{
                   let selectedCountry = pickerView.selectedRow(inComponent: 0)
                   return countries[selectedCountry].cities[row]
               }
    }
        
        if pickerView.tag == 2 {
            return CardiacData[row]
        }
        
        else {
            return ExtraData[row]
        }
        
    }
        
    
    @IBAction func Valvularr(_ sender: Any) {
        CardiacPickerView.isHidden = true
        ExtraPickerView.isHidden = true
        if pickerView.isHidden == true{
                   pickerView.isHidden = false
               }
        
    }
    
    @IBAction func Cardiac(_ sender: Any) {
        pickerView.isHidden = true
        ExtraPickerView.isHidden = true
        if CardiacPickerView.isHidden == true{
                   CardiacPickerView.isHidden = false
               }
        
    }
    
    
    @IBAction func Extra(_ sender: Any) {
        pickerView.isHidden = true
        CardiacPickerView.isHidden = true
        if ExtraPickerView.isHidden == true{
            ExtraPickerView.isHidden = false
        }
    }
    
    var countries = [Country]()
    
    
    
    
  
    
    
    @IBAction func Skip(_ sender: Any) {
        
         
        
        
        let dict:[String:String] = ["path":filePath,"location":location, "position":position, "diagnosis":"","patient":Patient]
        
         DatabaseHelper.shareInstance.saveAudio(object: dict)
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBOutlet weak var ValvularLabel: UIButton!
    
    
    @IBOutlet weak var CardLabel: UIButton!

    @IBOutlet weak var ExtraValvularLabel: UIButton!
    
    @IBOutlet weak var ExtraLabel: UILabel!
    @IBOutlet weak var cardiacLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var more: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var CardiacPickerView: UIPickerView!
    
    @IBOutlet weak var ExtraPickerView: UIPickerView!
    
    
    
    var Valvular =  UIPickerView()
    var Extra = UIPickerView()

    let CardiacData = ["Atrial Septal Defect","Tetralogy of Fallot","Ventricular Septal Defects","Complex Lesion"]
    
    let ExtraData = ["Patent Ductus Arterious(PDA)","Coarctation","Aortopulmonary Window/ Defect"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
        pickerView.isHidden = true
        CardiacPickerView.isHidden = true
        ExtraPickerView.isHidden = true
         
     }
    
    
//    @objc func didGetNotification3(_ notification: Notification){
//              let text3 = notification.object as! String?
//              filePath = text3
//          }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = ""
        comments.text = ""
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification3(_:)), name: Notification.Name("text3"), object: nil)
        Diagnosis = ""
        label.text = Diagnosis
        

        pickerView.isHidden = true
        CardiacPickerView.isHidden = true
        ExtraPickerView.isHidden = true
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        CardiacPickerView.delegate = self
        CardiacPickerView.dataSource = self
        
        ExtraPickerView.delegate = self
        ExtraPickerView.dataSource = self
        
        
        
        
        countries.append(Country(country: "Mitral Valve Disease", cities:["Stenosis","Regurgutation","Mixed Lesion","Prothetic Valve"] ))
         countries.append(Country(country: "Aortic Valve Disease", cities:["Stenosis","Regurgutation","Mixed Lesion","Prothetic Valve"] ))
        countries.append(Country(country: "Pulmonic Valve Disease", cities:["Stenosis","Regurgutation","Mixed Lesion","Prothetic Valve"] ))
        countries.append(Country(country: "Tricuspid Valve Disease", cities:["Stenosis","Regurgutation","Mixed Lesion","Prothetic Valve"] ))
        
        pickerView.tag = 1
        CardiacPickerView.tag = 2
        ExtraPickerView.tag = 3

        
               
//        pickerView.delegate = self
//        pickerView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }

    
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
            let VC = recordViewController()
        
            location = object["location"]
            position = object["position"]
            VC.FilePath = object["path"]!
            label.text = object["diagnosis"]
        
            i = index
            isUpdate = isEdit
        
        do {
                              try DatabaseHelper.shareInstance.context.save()
                          }catch{
                              print("Data is not edited")
               
                          }
               
 
        }
    
   
     func editData(object:[String:String], i: Int){
        let Audio = DatabaseHelper.shareInstance.getAllAudioData()
    //               Student = Student.filter{
    //                   ($0.drID?.contains(drID))!
    //               }
        
                   Audio[i].audioPath = object["path"]
                   Audio[i].location = object["location"]
                   Audio[i].position = object["position"]
                    label.text = object["diagnosis"]
                   

                   do {
                       try DatabaseHelper.shareInstance.context.save()
                   }catch{
                       print("Data is not edited")
        
                   }
        
        
               }
    
    @IBAction func done(_ sender: Any) {
        
      
        if label.text == "" {
            let alertView = UIAlertController(title: "Alert", message: "Diagnosis Empty", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                })
        alertView.addAction(okAction)
        alertView.view.tintColor = UIColor.black
        self.present(alertView, animated: true, completion: nil)
            
        return
        }
        
        
        
        print(filePath)
        print(location)
        print(position)
        print(label.text as Any)
        
        if isUpdate == true{
            
            if label.text == "" {
            let alertView = UIAlertController(title: "Alert", message: "Diagnosis Empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                    
                    })
            alertView.addAction(okAction)
                alertView.view.tintColor = UIColor.black
            self.present(alertView, animated: true, completion: nil)
                           
                           
            return
        }
            
            
            
            
//            label.text = label.text! + " " + comments.text!
            let dict:[String:String] = ["path":filePath,"location":location, "position":position, "diagnosis":label.text!, "patient":Patient]
            
            self.editData(object: dict, i: i)
            
            
            let alertView = UIAlertController(title: "Success", message: "Diagnosis Updated Successfully ", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                   self.dismiss(animated: true, completion: nil)
                          
                               })
                            alertView.addAction(okAction)
            alertView.view.tintColor = UIColor.black
            self.present(alertView, animated: true, completion: nil)
            
            
            
            
            
                        
            
            let VC = SecondViewController()
            VC.arrData = DatabaseHelper.shareInstance.getAllData()
            
            print("it is true")
                        
                    }
        
        else {
            
            print(label)
            
            if label.text == "" {
                let alertView = UIAlertController(title: "Alert", message: "Diagnosis Empty", preferredStyle: .alert)
                                   let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                  
                                              })
                                           alertView.addAction(okAction)
                alertView.view.tintColor = UIColor.black
                           self.present(alertView, animated: true, completion: nil)
                
                
                return
            }
        

            let dict:[String:String] = ["path":filePath,"location":location, "position":position, "diagnosis":label.text!,"patient":Patient]
        
        DatabaseHelper.shareInstance.saveAudio(object: dict)
        let VC = SecondViewController()
        VC.arrData = DatabaseHelper.shareInstance.getAllData()
            
            
            
            let heartModel = HeartModel(base64_string_of_heart_audio_file: base64, patient_id: Patient, heart_diagnosis: label.text!)
                    

                    
                    
            APIManager.shareInstance.heartAPI(login: heartModel)
                    {
                        (isSuccess,str) in
                        if isSuccess{

                            print(str)
                            if str != "Please enter Email and Password!" && str != "Incorrect Password" && str != "Incorrect Email"{
                                print("Done")
            //                    let alertView = UIAlertController(title: "Success", message: "Logged in Successfully", preferredStyle: .alert)
            //                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in

                               
                               

            //                })
            //                                    alertView.addAction(okAction)
            //                                    self.present(alertView, animated: true, completion: nil)
                            }

                        
                          
                        }
                        else{

                            let alertView = UIAlertController(title: "Oops, network issue", message: str, preferredStyle: .alert)
                             let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                
                            })
                             alertView.addAction(okAction)
                            alertView.view.tintColor = UIColor.black
                             self.present(alertView, animated: true, completion: nil)
                        }
                    }
            
            
        
        
        let alertView = UIAlertController(title: "Success", message: "Audio Saved Successfully ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                           self.dismiss(animated: true, completion: nil)
                       })
                    alertView.addAction(okAction)
            alertView.view.tintColor = UIColor.black
                       
    self.present(alertView, animated: true, completion: nil)
        

    }
    }
}
