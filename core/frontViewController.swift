//
//  frontViewController.swift
//  core
//
//  Created by Apple on 16/07/2021.
//  Copyright © 2021 Yogesh Patel. All rights reserved.
//

import UIKit

class frontViewController: UIViewController {


    
    
    @IBOutlet weak var L1_Outlet: UIButton!
    
    @IBOutlet weak var R1_Outlet: UIButton!
    
    @IBAction func R1(_ sender: Any) {
       
               self.R1_Outlet.backgroundColor = UIColor.green
               self.L1_Outlet.backgroundColor = nil
    }
    
    @IBAction func L1(_ sender: Any) {
        
        self.R1_Outlet.backgroundColor = nil
        self.L1_Outlet.backgroundColor = UIColor.yellow
        
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
