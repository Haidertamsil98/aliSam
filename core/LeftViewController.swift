//
//  LeftViewController.swift
//  core
//
//  Created by Apple on 24/06/2021.
//  Copyright © 2021 Yogesh Patel. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var L3_Outlet: UIButton!
    
    @IBAction func L3(_ sender: Any) {
        if label.text == "L3"{
               label.text = "Location"
                                self.L3_Outlet.backgroundColor = nil
           }
           else {
               label.text = "L3"
               self.L3_Outlet.backgroundColor = UIColor.brown
           }
    }
    
    
    
    
    
    @IBAction func dismiss(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: recordViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
    }
    
    @IBAction func front(_ sender: Any) {
        
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "LungsViewController") as! LungsViewController
//        self.show(VC, sender: (Any).self)
    
//            self.present(VC, animated: false, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
       
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "BackViewController") as! BackViewController
                     self.show(VC, sender: (Any).self)
    }
    
    
    @IBAction func right(_ sender: Any) {
       
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "rightViewController") as! rightViewController
                     self.show(VC, sender: (Any).self)
    }
    
    
    @IBAction func left(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
                      self.show(VC, sender: (Any).self)
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
