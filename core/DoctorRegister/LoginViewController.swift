//
//  LoginViewController.swift
//  core
//
//  Created by Apple on 28/07/2021.



import UIKit
import AWSSigner

class LoginViewController: UIViewController, UITextFieldDelegate {
    static let shareInstance = LoginViewController()
    
    var drID:String!=nil
    
    var homeViewController: homeViewController?
    
    
    @IBAction func back(_ sender: Any) {
    
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet var emailBackView: UIView!
    
    
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    
    @IBAction func backk(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
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
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController

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
                alertView.view.tintColor = UIColor.black
                 self.present(alertView, animated: true, completion: nil)
            }
            else{

                let alertView = UIAlertController(title: "Please check your credentials and try again", message: str, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    self.progress.stopAnimating()
                })
                 alertView.addAction(okAction)
                alertView.view.tintColor = UIColor.black
                 self.present(alertView, animated: true, completion: nil)
            }
            
            
            
            print("im hereeee.....")
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        addBottomBorder(to: emailBackView, color: UIColor.black, thickness: 1.0)
        addBottomBorder(to: passView, color: UIColor.black, thickness: 1.0)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var passView: UIView!
    
    func addBottomBorder(to view: UIView, color: UIColor, thickness: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: view.frame.size.height - thickness, width: view.frame.size.width, height: thickness)
            view.layer.addSublayer(border)
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
