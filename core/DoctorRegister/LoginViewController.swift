//
//  LoginViewController.swift
//  core
//
//  Created by Apple on 28/07/2021.



import UIKit
import AWSSigner

class LoginViewController: UIViewController {
    static let shareInstance = LoginViewController()
    
    var drID:String!=nil
    
    var homeViewController: homeViewController?
    
    
    @IBAction func back(_ sender: Any) {
    
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        progress.startAnimating()
        
        guard let email_ = email.text else { return }
        guard let password_ = password.text else { return }
        let loginModel = LoginModel(email: email_ , password: password_)
        

        
        
        APIManager.shareInstance.callingLoginAPI(login: loginModel)
        {
            (isSuccess,str) in
            if isSuccess{

                print(str)
                if str != "Please enter Email and Password!" && str != "Incorrect Password" && str != "Incorrect Email"{

//                    let alertView = UIAlertController(title: "Success", message: "Logged in Successfully", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in

                    self.progress.stopAnimating()
                    print("Dr ID", str)



                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "toolbar")
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController

                    home.drID = str
                     Services.ServicesInstance.savedToken(token:APIManager.shareInstance.drID)
                    self.present(VC!, animated: true, completion: nil)

//                })
//                                    alertView.addAction(okAction)
//                                    self.present(alertView, animated: true, completion: nil)
                }

            
               let alertView = UIAlertController(title: "Failed", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    self.progress.stopAnimating()


                })
                 alertView.addAction(okAction)
                 self.present(alertView, animated: true, completion: nil)
            }
            else{

                let alertView = UIAlertController(title: "Please check your credentials and try again", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    self.progress.stopAnimating()
                })
                 alertView.addAction(okAction)
                 self.present(alertView, animated: true, completion: nil)
            }
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
