//
//  BPViewController.swift
//  core
//
//  Created by Mac on 05/10/2022.
//  Copyright © 2022 Haider Tamsil. All rights reserved.
//

//
//  LungsViewController.swift
//  core
//
//  Created by Apple on 24/06/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import UIKit

class BPViewController: UIViewController {
    
  
    
    @IBOutlet weak var label: UILabel!
    
   
    
    @IBOutlet weak var imageView: UIImageView!
    

      override func viewDidLoad() {
        super.viewDidLoad()
          R1_Outlet.isHidden = true
          L1_Outlet.isHidden = false
          
          leftOutlet.backgroundColor = .systemGray5
          rightOutlet.backgroundColor = .clear

    }
    
    //LocationButtons
    //front
    
    @IBOutlet weak var R1_Outlet: UIButton!
    @IBOutlet weak var L1_Outlet: UIButton!
    
    
    
    @IBAction func RI(_ sender: Any) {
        R1_Outlet.backgroundColor = UIColor.green
        label.text = "R1"
    }
    
    
    @IBAction func L1(_ sender: Any) {
       
        L1_Outlet.backgroundColor = UIColor.yellow
        label.text = "L1"
        
    }
    
    //back

   
    
    
    
    @IBOutlet weak var rightOutlet: UIButton!
    
    @IBOutlet weak var leftOutlet: UIButton!
    
    
    
    
    
    @IBAction func right(_ sender: Any) {
        R1_Outlet.isHidden = false
        L1_Outlet.isHidden = true
   
   
        
        
        leftOutlet.backgroundColor = .clear
        rightOutlet.backgroundColor = .systemGray5
        
            
        
        
        
        
    imageView.image = UIImage(named: "BP_right")
    }
    
    
    @IBAction func left(_ sender: Any) {
        

        R1_Outlet.isHidden = true
        L1_Outlet.isHidden = false
      
        leftOutlet.backgroundColor = .systemGray5
        rightOutlet.backgroundColor = .clear
        
        
        
        
        
         imageView.image = UIImage(named: "BP_left")
    }
    
 

    @IBAction func next(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name("text"), object: label.text)
      
        dismiss(animated:true, completion: nil)
       
        
        
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
}


