//
//  passViewController.swift
//  core
//
//  Created by Apple on 12/08/2021.
//  Copyright © 2021 Yogesh Patel. All rights reserved.
//

import UIKit

class passViewController: UIViewController {

    @IBOutlet weak var cnic: UITextField!
    
    
    @IBOutlet var CNICbackView: UIView!
    
    
    @IBOutlet var passBackView: UIView!
    func addBottomBorder(to view: UIView, color: UIColor, thickness: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: view.frame.size.height - thickness, width: view.frame.size.width, height: thickness)
            view.layer.addSublayer(border)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
           
        
                if cnic.text != "" {
                    if (cnic.text?.contains("-"))!{
                        return
                    }
                
                    if cnic.text?.count == 13{
                        
                        print(cnic.text?.count)
                           let strIndex = cnic.text?.index(cnic.text!.startIndex, offsetBy: 5)
        //                   let strIndex2 = CNIC.text?.index(CNIC.text!.startIndex, offsetBy: 10)
                        
                       cnic.text?.insert("-", at: strIndex!)
        //                CNIC.text?.insert("-", at: strIndex2!)
                        let strIndex3 = cnic.text?.index(cnic.text!.startIndex, offsetBy: 13)
                       cnic.text?.insert("-", at: strIndex3!)
                        
                        cnic.backgroundColor = .white
                       }
                    if cnic.text!.isValidCnic {
                        cnic.backgroundColor = .white
                    }
                }

        
        
        
    }
    
    
    
    
    
    
    
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var newpass: UITextField!
    

    @IBAction func update(_ sender: Any) {
        
        progress.startAnimating()
        guard let cnic = cnic.text else { return }
        guard let password = newpass.text else { return }
        let forgotModel = Forgot(old_cnic: cnic, new_password: password)
        
        APIManager.shareInstance.callingForgotPasswordAPI(register: forgotModel)
                {
                    (isSuccess,str) in
                    if isSuccess{
                       
                        
                       let alertView = UIAlertController(title: "Success", message: str, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            
                            self.progress.stopAnimating()
                            self.dismiss(animated: true, completion: nil)
                            
                        })
                        alertView.addAction(okAction)
                        alertView.view.tintColor = UIColor.black
                        self.present(alertView, animated: true, completion: nil)
                        
        //               let alertView = UIAlertController(title: "Alert", message: str, preferredStyle: .alert)
        //                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
        //                })
        //                 alertView.addAction(okAction)
        //                 self.present(alertView, animated: true, completion: nil)
                    }
                    else{
                
                        let alertView = UIAlertController(title: "Failed", message: str, preferredStyle: .alert)
                         let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            
                            self.progress.stopAnimating()
                        })
                         alertView.addAction(okAction)
                        alertView.view.tintColor = UIColor.black
                         self.present(alertView, animated: true, completion: nil)
                    }
                }

    }
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addBottomBorder(to: CNICbackView, color: UIColor.black, thickness: 1.0)
        addBottomBorder(to: passBackView, color: UIColor.black, thickness: 1.0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
