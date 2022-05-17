//
//  LocationViewController.swift
//  core
//
//  Created by Apple on 27/04/2021.
//  Copyright © 2021 Haider Tamsil All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    var marran:String = ""
    
    @IBOutlet weak var Label: UILabel!
    
    @IBAction func next(_ sender: Any) {
        
        
        NotificationCenter.default.post(name: Notification.Name("text"), object: Label.text)
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var onebtn: UIButton!
    @IBAction func one(_ sender: Any) {
        Label.text = "Mitral"
        self.onebtn.backgroundColor = UIColor.purple
        self.twobtn.backgroundColor = nil
        self.btnthree.backgroundColor = nil
        self.btnfour.backgroundColor = nil
    }
    
   
    
 
    @IBOutlet weak var twobtn: UIButton!
    @IBAction func two(_ sender: Any) {
        
         self.twobtn.backgroundColor = UIColor.green
        Label.text = "Tricuspid"
        self.onebtn.backgroundColor = nil
        self.btnthree.backgroundColor = nil
        self.btnfour.backgroundColor = nil
        
    }
    
    
    @IBOutlet weak var btnthree: UIButton!
    
    @IBAction func three(_ sender: Any) {
        
        self.btnthree.backgroundColor = UIColor.init(red: 0, green: 0, blue: 100, alpha: 1)
        self.twobtn.backgroundColor = nil
        Label.text = "Pulmonary"
        self.onebtn.backgroundColor = nil
        self.btnfour.backgroundColor = nil
    }
    
    
    @IBAction func four(_ sender: Any) {
        self.btnfour.backgroundColor = UIColor.red
        self.twobtn.backgroundColor = nil
        Label.text = "Aortic"
        self.onebtn.backgroundColor = nil
        self.btnthree.backgroundColor = nil
    }
    
    
    
    
    
    @IBOutlet weak var btnfour: UIButton!
    
    @IBAction func dismiss(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = ""
        
        if marran == "1"{
            
        }
        
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
