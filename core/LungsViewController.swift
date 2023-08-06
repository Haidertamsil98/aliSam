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
        
          unhide_front()
          hide_all_back()
          hide_all_right()
          hide_all_left()
          
          
          frontOutlet.backgroundColor = .systemGray5
          backOutlet.backgroundColor = .clear
          leftOutlet.backgroundColor = .clear
          rightOutlet.backgroundColor = .clear
    }
    
    //LocationButtons
    //front
    
    @IBOutlet weak var R1_Outlet: UIButton!
    @IBOutlet weak var L1_Outlet: UIButton!
    
    @IBOutlet weak var R2_Outlet: UIButton!
    @IBOutlet weak var L2_Outlet: UIButton!
    
    @IBOutlet weak var R3_Outlet: UIButton!
    @IBOutlet weak var L3_Outlet: UIButton!
    
    @IBOutlet weak var R4_Outlet: UIButton!
    @IBOutlet weak var L4_Outlet: UIButton!
    
    @IBOutlet weak var R5_Outlet: UIButton!
    @IBOutlet weak var L5_Outlet: UIButton!
    
    @IBOutlet weak var R6_Outlet: UIButton!
    @IBOutlet weak var L6_Outlet: UIButton!
    
    func all_Nil(){
        R1_Outlet.backgroundColor = nil
        L1_Outlet.backgroundColor = nil
        
        R2_Outlet.backgroundColor = nil
        L2_Outlet.backgroundColor = nil
        
        R3_Outlet.backgroundColor = nil
        L3_Outlet.backgroundColor = nil
        
        R4_Outlet.backgroundColor = nil
        L4_Outlet.backgroundColor = nil
        
        R5_Outlet.backgroundColor = nil
        L5_Outlet.backgroundColor = nil
        
        L6_Outlet.backgroundColor = nil
        R6_Outlet.backgroundColor = nil
    }
    
    func all_nil_b(){
        
        B_R1_Outlet.backgroundColor = nil
        B_L1_Outlet.backgroundColor = nil
        
        B_R2_Outlet.backgroundColor = nil
        B_L2_Outlet.backgroundColor = nil
        
        B_R3_Outlet.backgroundColor = nil
        B_L3_Outlet.backgroundColor = nil
        
        B_R4_Outlet.backgroundColor = nil
        B_L4_Outlet.backgroundColor = nil
        
        B_R5_Outlet.backgroundColor = nil
        B_L5_Outlet.backgroundColor = nil
        
        B_L6_Outlet.backgroundColor = nil
        B_R6_Outlet.backgroundColor = nil
        
        B_L7_Outlet.backgroundColor = nil
        B_R7_Outlet.backgroundColor = nil
    }

    func hide_all_front(){
        R1_Outlet.isHidden = true
        L1_Outlet.isHidden = true
        R2_Outlet.isHidden = true
        L2_Outlet.isHidden = true
        R3_Outlet.isHidden = true
        L3_Outlet.isHidden = true
        
        R4_Outlet.isHidden = true
        L4_Outlet.isHidden = true
        
        R5_Outlet.isHidden = true
        L5_Outlet.isHidden = true
        
        L6_Outlet.isHidden = true
        R6_Outlet.isHidden = true
        
    }
    
    func hide_all_back(){
        B_R1_Outlet.isHidden = true
        B_L1_Outlet.isHidden = true
        B_R2_Outlet.isHidden = true
        B_L2_Outlet.isHidden = true
        B_R3_Outlet.isHidden = true
        B_L3_Outlet.isHidden = true
        
        B_R4_Outlet.isHidden = true
        B_L4_Outlet.isHidden = true
        
        B_R5_Outlet.isHidden = true
        B_L5_Outlet.isHidden = true
        
        B_L6_Outlet.isHidden = true
        B_R6_Outlet.isHidden = true
        
        B_L7_Outlet.isHidden = true
        B_R7_Outlet.isHidden = true
        
    }
    
    func hide_all_right(){
        R_R1.isHidden = true
        R_R2.isHidden = true
        R_R3.isHidden = true
    }
    
    func hide_all_left(){
        L_L1.isHidden = true
        L_L2.isHidden = true
        L_L3.isHidden = true
    }
    
    func unhide_all_left(){
        L_L1.isHidden = false
        L_L2.isHidden = false
        L_L3.isHidden = false
    }
    func all_nil_R(){
        R_R1.backgroundColor = nil
        R_R2.backgroundColor = nil
        R_R3.backgroundColor = nil
    }
    func all_nil_L(){
        L_L1.backgroundColor = nil
        L_L2.backgroundColor = nil
        L_L3.backgroundColor = nil
    }
    
    
    func unhide_all_right(){
        R_R1.isHidden = false
        R_R2.isHidden = false
        R_R3.isHidden = false
    }
    
    
    func unhide_front(){
        R1_Outlet.isHidden = false
        L1_Outlet.isHidden = false
        R2_Outlet.isHidden = false
        L2_Outlet.isHidden = false
        R3_Outlet.isHidden = false
        L3_Outlet.isHidden = false
        
        R4_Outlet.isHidden = false
        L4_Outlet.isHidden = false
        
        R5_Outlet.isHidden = false
        L5_Outlet.isHidden = false
        
        L6_Outlet.isHidden = false
        R6_Outlet.isHidden = false
        
    }
    
    
    func unhide_back(){
        B_R1_Outlet.isHidden = false
        B_L1_Outlet.isHidden = false
        B_R2_Outlet.isHidden = false
        B_L2_Outlet.isHidden = false
        B_R3_Outlet.isHidden = false
        B_L3_Outlet.isHidden = false
        
        B_R4_Outlet.isHidden = false
        B_L4_Outlet.isHidden = false
        
        B_R5_Outlet.isHidden = false
        B_L5_Outlet.isHidden = false
        
        B_L6_Outlet.isHidden = false
        B_R6_Outlet.isHidden = false
        
        B_L7_Outlet.isHidden = false
        B_R7_Outlet.isHidden = false
    }
    
    
    @IBAction func RI(_ sender: Any) {
        all_Nil()
        R1_Outlet.backgroundColor = UIColor.green
        label.text = "R1"
    }
    
    
    @IBAction func L1(_ sender: Any) {
        all_Nil()
        L1_Outlet.backgroundColor = UIColor.yellow
        label.text = "L1"
        
    }
    
    //back

    
    @IBAction func R2(_ sender: Any) {
        all_Nil()
        R2_Outlet.backgroundColor = UIColor.green
        label.text = "R2"
        
        
    }
    @IBAction func L2(_ sender: Any) {
        
        all_Nil()
        L2_Outlet.backgroundColor = UIColor.yellow
        label.text = "L2"
    }
    
    
    
    
    
    //Righttt
    
    
    @IBAction func R3(_ sender: Any) {
        all_Nil()
        R3_Outlet.backgroundColor = UIColor.green
        label.text = "R3"
    }
    
    //leftt
    
    
    @IBAction func L3(_ sender: Any) {
        all_Nil()
        L3_Outlet.backgroundColor = UIColor.yellow
        label.text = "L3"
    }
    
    
    
    
    @IBAction func R4(_ sender: Any) {
        all_Nil()
        R4_Outlet.backgroundColor = UIColor.green
        label.text = "R4"
    }
    
    
    @IBAction func L4(_ sender: Any) {
        all_Nil()
        L4_Outlet.backgroundColor = UIColor.yellow
        label.text = "L4"
    }
    
    
    @IBAction func R5(_ sender: Any) {
        all_Nil()
        R5_Outlet.backgroundColor = UIColor.green
        label.text = "R5"
    }
    
    
    @IBAction func L5(_ sender: Any) {
        all_Nil()
        L5_Outlet.backgroundColor = UIColor.yellow
        label.text = "L5"
    }
    
    
    
    @IBAction func R6(_ sender: Any) {
        all_Nil()
        R6_Outlet.backgroundColor = UIColor.green
        label.text = "R6"
    }
    
    
    @IBAction func L6(_ sender: Any) {
        all_Nil()
        L6_Outlet.backgroundColor = UIColor.yellow
        label.text = "L6"
    }
    
    
    
    //BACK
    
    
    
    @IBOutlet weak var B_L1_Outlet: UIButton!
    @IBOutlet weak var B_R1_Outlet: UIButton!
    
    
    
    @IBOutlet weak var B_L2_Outlet: UIButton!
    @IBOutlet weak var B_R2_Outlet: UIButton!
    
    
    
    @IBOutlet weak var B_L3_Outlet: UIButton!
    @IBOutlet weak var B_R3_Outlet: UIButton!
    
    
    @IBOutlet weak var B_L4_Outlet: UIButton!
    @IBOutlet weak var B_R4_Outlet: UIButton!
    
    
    @IBOutlet weak var B_L5_Outlet: UIButton!
    @IBOutlet weak var B_R5_Outlet: UIButton!
    
    
    @IBOutlet weak var B_L6_Outlet: UIButton!
    @IBOutlet weak var B_R6_Outlet: UIButton!
    
    
    
    @IBOutlet weak var B_L7_Outlet: UIButton!
    @IBOutlet weak var B_R7_Outlet: UIButton!
    
    
    
    
    @IBAction func B_L1(_ sender: Any) {
        all_nil_b()
        B_L1_Outlet.backgroundColor = UIColor.yellow
        label.text = "L1"
    }
    
    
    @IBAction func B_R1(_ sender: Any) {
        all_nil_b()
        B_R1_Outlet.backgroundColor = UIColor.green
        label.text = "R1"
    }
    
    
    
    @IBAction func B_L2(_ sender: Any) {
        all_nil_b()
        B_L2_Outlet.backgroundColor = UIColor.yellow
        label.text = "L2"
    }
    
    
    
    @IBAction func B_R2(_ sender: Any) {
        all_nil_b()
        B_R2_Outlet.backgroundColor = UIColor.green
        label.text = "R2"
    }
    
    
    
    
    @IBAction func B_L3(_ sender: Any) {
        all_nil_b()
        B_L3_Outlet.backgroundColor = UIColor.yellow
        label.text = "L3"
    }
    
    
    
    @IBAction func B_R3(_ sender: Any) {
        all_nil_b()
        B_R3_Outlet.backgroundColor = UIColor.green
        label.text = "R3"
    }
    
    
    
    
    @IBAction func B_L4(_ sender: Any) {
        all_nil_b()
        B_L4_Outlet.backgroundColor = UIColor.yellow
        label.text = "L4"
    }
    
    
    @IBAction func B_R4(_ sender: Any) {
        all_nil_b()
        B_R4_Outlet.backgroundColor = UIColor.green
        label.text = "R4"
    }
    
    
    
    @IBAction func B_L5(_ sender: Any) {
        all_nil_b()
        B_L5_Outlet.backgroundColor = UIColor.yellow
        label.text = "L5"
    }
    
    
    @IBAction func B_R5(_ sender: Any) {
        all_nil_b()
        B_R5_Outlet.backgroundColor = UIColor.green
        label.text = "R5"
    }
    
    
    @IBAction func B_L6(_ sender: Any) {
        all_nil_b()
        B_L6_Outlet.backgroundColor = UIColor.yellow
        label.text = "L6"
    }
    
    
    @IBAction func B_R6(_ sender: Any) {
        all_nil_b()
        B_R6_Outlet.backgroundColor = UIColor.green
        label.text = "R6"
    }
    
    
    
    @IBAction func B_L7(_ sender: Any) {
        all_nil_b()
        B_L7_Outlet.backgroundColor = UIColor.yellow
        label.text = "L7"
    }
    
    @IBAction func B_R7(_ sender: Any) {
        all_nil_b()
        B_R7_Outlet.backgroundColor = UIColor.green
        label.text = "R7"
    }
    
    
    @IBOutlet weak var R_R1: UIButton!
    @IBOutlet weak var R_R2: UIButton!
    @IBOutlet weak var R_R3: UIButton!
    
    
    
    
    
    
    @IBOutlet weak var L_L1: UIButton!
    @IBOutlet weak var L_L2: UIButton!
    @IBOutlet weak var L_L3: UIButton!
    
    
    
    @IBAction func R_R1(_ sender: Any) {
        all_nil_R()
        R_R1.backgroundColor = UIColor.green
        label.text = "R1"
    }
    
    
    @IBAction func R_R2(_ sender: Any) {
        all_nil_R()
        R_R2.backgroundColor = UIColor.green
        label.text = "R2"
    }
    
    
    
    @IBAction func R_R3(_ sender: Any) {
        all_nil_R()
        R_R3.backgroundColor = UIColor.green
        label.text = "R3"
    }
    
    
    
    @IBAction func L_L1(_ sender: Any) {
        all_nil_L()
        L_L1.backgroundColor = UIColor.yellow
        label.text = "L1"
    }
    
    
    @IBAction func L_L2(_ sender: Any) {
        all_nil_L()
        L_L2.backgroundColor = UIColor.yellow
        label.text = "L2"
    }
    
    
    @IBAction func L_L3(_ sender: Any) {
        all_nil_L()
        L_L3.backgroundColor = UIColor.yellow
        label.text = "L3"
    }
    
    
    
    
    
    
    @IBOutlet weak var frontOutlet: UIButton!
    
    @IBOutlet weak var backOutlet: UIButton!
    
    @IBOutlet weak var rightOutlet: UIButton!
    
    @IBOutlet weak var leftOutlet: UIButton!
    
    
    
    
    @IBAction func front(_ sender: Any) {
        all_nil_R()
        all_nil_L()

        hide_all_right()
        hide_all_left()
        unhide_front()
        hide_all_back()
//        frontOutlet.tintColor = .systemBlue
//        backOutlet.tintColor = .black
//        leftOutlet.tintColor = .black
//        rightOutlet.tintColor = .black
        
        frontOutlet.backgroundColor = .systemGray5
        backOutlet.backgroundColor = .clear
        leftOutlet.backgroundColor = .clear
        rightOutlet.backgroundColor = .clear
        
        
        
        imageView.image = UIImage(named: "front")
    
    }
    
    @IBAction func back(_ sender: Any) {
        
        all_nil_R()
        all_nil_L()
        hide_all_right()
        hide_all_left()
        hide_all_front()
        unhide_back()
//        frontOutlet.tintColor = .black
//        backOutlet.tintColor = .systemBlue
//        leftOutlet.tintColor = .black
//        rightOutlet.tintColor = .black
        
        frontOutlet.backgroundColor = .clear
        backOutlet.backgroundColor = .systemGray5
        leftOutlet.backgroundColor = .clear
        rightOutlet.backgroundColor = .clear
        
        
        
        imageView.image = UIImage(named: "back")
    }
    
    
    @IBAction func right(_ sender: Any) {
        
    all_nil_L()
    unhide_all_right()
    hide_all_left()
    hide_all_back()
    hide_all_front()
    all_Nil()
    all_nil_b()
//    frontOutlet.tintColor = .black
//    backOutlet.tintColor = .black
//    leftOutlet.tintColor = .black
//    rightOutlet.tintColor = .systemBlue
        
        frontOutlet.backgroundColor = .clear
        backOutlet.backgroundColor = .clear
        leftOutlet.backgroundColor = .clear
        rightOutlet.backgroundColor = .systemGray5
        
        
        
    imageView.image = UIImage(named: "lungs_right_side")
    }
    
    
    @IBAction func left(_ sender: Any) {
        

        hide_all_back()
        hide_all_front()
        all_Nil()
        all_nil_b()
        all_nil_R()
        hide_all_right()
        unhide_all_left()
//        frontOutlet.tintColor = .black
//        backOutlet.tintColor = .black
//        leftOutlet.tintColor = .systemBlue
//        rightOutlet.tintColor = .black
        
        
        frontOutlet.backgroundColor = .clear
        backOutlet.backgroundColor = .clear
        leftOutlet.backgroundColor = .systemGray5
        rightOutlet.backgroundColor = .clear
        
        
        
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


