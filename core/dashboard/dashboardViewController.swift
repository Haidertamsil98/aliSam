//
//  dashboardViewController.swift
//  core
//
//  Created by Apple on 01/08/2021.
//  Copyright © 2021 Yogesh Patel. All rights reserved.
//

import UIKit

class dashboardViewController: UIViewController {

    
    
    
    
    
    @IBOutlet weak var label: UILabel!
    var strName = ""
    @IBOutlet weak var logout: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = strName
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

extension dashboardViewController{
    static func shareInstance() -> dashboardViewController{
        return dashboardViewController.shareInstance()
    }
}
