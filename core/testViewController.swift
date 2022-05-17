//
//  testViewController.swift
//  
//
//  Created by Apple on 25/12/2021.
//

import UIKit

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var name: UITextField!
    
    
    
    @IBAction func login(_ sender: Any) {
        
        
        guard let fname = self.name.text else { return }
        
        let register = securedApi(name: fname)
        APIManager.shareInstance.securedAPI(register: register)
        {
            (isSuccess,str) in
            if isSuccess{
                
                if str != "Doctor with the provided email or CNIC already exists"{
                
                    let alertView = UIAlertController(title: "Success", message: "Registered Successfully", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                        
//                        self.progress.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                                        
                                        
                                       
                })
                                    alertView.addAction(okAction)
                                    self.present(alertView, animated: true, completion: nil)
                    
                
                }
                
               let alertView = UIAlertController(title: "Failed", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
//                    self.progress.stopAnimating()
                })
                 alertView.addAction(okAction)
                 self.present(alertView, animated: true, completion: nil)
                
            }
            else{
            
                let alertView = UIAlertController(title: "Oops, network issue", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
//                    self.progress.stopAnimating()
                })
                 alertView.addAction(okAction)
                 self.present(alertView, animated: true, completion: nil)
            }
        }
    
}
}
