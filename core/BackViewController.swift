//
//  BackViewController.swift
//  core
//
//  Created by Apple on 24/06/2021.
//  Copyright © 2021 Yogesh Patel. All rights reserved.
//

import UIKit

class BackViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var R2_Outlet: UIButton!
    
    @IBOutlet weak var R1_Outlet: UIButton!
    
    
    @IBAction func R2(_ sender: Any) {
        label.text = "R2"
                      self.R2_Outlet.backgroundColor = UIColor.green
                      self.R1_Outlet.backgroundColor = nil
    }
    
    
    @IBAction func L2(_ sender: Any) {
        label.text = "L2"
                             self.R2_Outlet.backgroundColor = nil
        self.R1_Outlet.backgroundColor = UIColor.orange
    }
    
    
    
    @IBAction func dismiss(_ sender: Any) {
     for controller in self.navigationController!.viewControllers as Array {
                 if controller.isKind(of: recordViewController.self) {
                     self.navigationController!.popToViewController(controller, animated: true)
                     break
                 }
             }
    }
    
    @IBAction func next(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "recordViewController") as! recordViewController
        VC.location = label.text
        print(VC.location)
        
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
