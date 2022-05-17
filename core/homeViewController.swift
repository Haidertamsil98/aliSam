//
//  homeViewController.swift
//  core
//
//  Created by Apple on 08/06/2021.
//  Copyright © 2021 HaiderTamsil. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {
    

    var drID:String!=nil
    
    var LoginViewController: LoginViewController?
    
    

    
    
    @IBAction func logout(_ sender: Any) {
        
        let alertView = UIAlertController(title: "", message: "Are you sure you want Logout? ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            Services.ServicesInstance.removedToken()
            
            
            self.present(VC, animated: true, completion: nil)
                       })
                       let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
                            print("Cancel")
                       })
                       alertView.addAction(okAction)
                       alertView.addAction(cancelAction)
                       self.present(alertView, animated: true, completion: nil)
        
    }
    
    
    
    @objc func didGetNotification(_ notification: Notification){
           let text = notification.object as! String?
//           drID = text
//            print("dr id from home view controller", drID)
       }
    
    
 
    override func viewDidLoad() {
    super.viewDidLoad()
    
        
        let drID = APIManager.shareInstance.drID
        print("dr id from home view controller", drID )
        
     NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
    
    
    }
    
}



    

