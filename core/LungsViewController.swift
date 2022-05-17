//
//  LungsViewController.swift
//  core
//
//  Created by Apple on 24/06/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import UIKit

class LungsViewController: UIViewController {
    
  
    
    @IBOutlet weak var label: UILabel!
    
   
    
    @IBOutlet weak var imageView: UIImageView!
    

      override func viewDidLoad() {
        super.viewDidLoad()
        frontOutlet.tintColor = .black
        
        R2_Outlet.isHidden = true
        L2_Outlet.isHidden = true
        
        R3_Outlet.isHidden = true

         L3_Outlet.isHidden = true
    }
    
    //LocationButtons
    //front
    
    @IBOutlet weak var R1_Outlet: UIButton!
    @IBOutlet weak var L1_Outlet: UIButton!
    
    @IBAction func RI(_ sender: Any) {
        R1_Outlet.backgroundColor = UIColor.green
        L1_Outlet.backgroundColor = nil
        label.text = "R1"
    }
    
    
    @IBAction func L1(_ sender: Any) {
         L1_Outlet.backgroundColor = UIColor.yellow
        R1_Outlet.backgroundColor = nil
        label.text = "L1"
        
    }
    
    //back

    @IBOutlet weak var R2_Outlet: UIButton!
    
    @IBAction func R2(_ sender: Any) {
        R2_Outlet.backgroundColor = UIColor.green
        L2_Outlet.backgroundColor = nil
        label.text = "R2"
        
        
    }
    @IBAction func L2(_ sender: Any) {
        
        L2_Outlet.backgroundColor = UIColor.orange
        R2_Outlet.backgroundColor = nil
        label.text = "L2"
    }
    
    
    @IBOutlet weak var L2_Outlet: UIButton!
    
    
    
    //Righttt
    
    
    @IBOutlet weak var R3_Outlet: UIButton!
    @IBAction func R3(_ sender: Any) {
        
        R3_Outlet.backgroundColor = UIColor.brown
        label.text = "R3"
    }
    
    //leftt
    
    @IBOutlet weak var L3_Outlet: UIButton!
    
    @IBAction func L3(_ sender: Any) {
        L3_Outlet.backgroundColor = UIColor.brown
              label.text = "L3"
    }
    
    
    
    
    @IBOutlet weak var frontOutlet: UIButton!
    
    @IBOutlet weak var backOutlet: UIButton!
    
    @IBOutlet weak var rightOutlet: UIButton!
    
    @IBOutlet weak var leftOutlet: UIButton!
    
    
    
    
    @IBAction func front(_ sender: Any) {
        R1_Outlet.isHidden = false
        L1_Outlet.isHidden = false
        
        R2_Outlet.isHidden = true
        L2_Outlet.isHidden = true
        
        R3_Outlet.isHidden = true
        
        L3_Outlet.isHidden = true
        
        frontOutlet.tintColor = .black
        backOutlet.tintColor = .systemBlue
        leftOutlet.tintColor = .systemBlue
        rightOutlet.tintColor = .systemBlue
        
        
        imageView.image = UIImage(named: "lungs_frontview")
    
    }
    
    @IBAction func back(_ sender: Any) {
        
        R1_Outlet.isHidden = true
        L1_Outlet.isHidden = true
        
        R2_Outlet.isHidden = false
        L2_Outlet.isHidden = false
        
        R3_Outlet.isHidden = true
        
         L3_Outlet.isHidden = true

        frontOutlet.tintColor = .systemBlue
        backOutlet.tintColor = .black
        leftOutlet.tintColor = .systemBlue
        rightOutlet.tintColor = .systemBlue
        
        
        imageView.image = UIImage(named: "lungs_backview")
    }
    
    
    @IBAction func right(_ sender: Any) {
        
    R1_Outlet.isHidden = true
    L1_Outlet.isHidden = true
              
    R2_Outlet.isHidden = true
    L2_Outlet.isHidden = true
        
        R3_Outlet.isHidden = false
         L3_Outlet.isHidden = true
        
        
        frontOutlet.tintColor = .systemBlue
        backOutlet.tintColor = .systemBlue
        leftOutlet.tintColor = .systemBlue
        rightOutlet.tintColor = .black
        
        
        
         imageView.image = UIImage(named: "lungs_right_side")
    }
    
    
    @IBAction func left(_ sender: Any) {
        
        R1_Outlet.isHidden = true
        L1_Outlet.isHidden = true
                  
        R2_Outlet.isHidden = true
        L2_Outlet.isHidden = true
            
        R3_Outlet.isHidden = true
        
        L3_Outlet.isHidden = false
        
        frontOutlet.tintColor = .systemBlue
        backOutlet.tintColor = .systemBlue
        leftOutlet.tintColor = .black
        rightOutlet.tintColor = .systemBlue
        
        
        
        
         imageView.image = UIImage(named: "lungs_left_side")
    }
    
 

    @IBAction func next(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name("text"), object: label.text)
      
        dismiss(animated:true, completion: nil)
       
        
        
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
}
