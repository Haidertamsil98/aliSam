//
//  loginViewController.swift
//  core
//
//  Created by Apple on 29/04/2021.
//  Copyright © 2021 HaiderTamsil. All rights reserved.
//

import UIKit

//class loginViewController: UIViewController {
//
//
//
//
//
//    @IBAction func next(_ sender: Any) {
//
//        if idtxt?.text == dr1 || idtxt?.text == dr2 || idtxt?.text == dr3{
//            idtxt.backgroundColor = .white
//
//            let formVC = ViewController()
////            let formVC = self.storyboard?.instantiateViewController(withIdentifier: "viewcontroller") as! ViewController
//
//            formVC.drID = dr1
//            formVC.drID = dr2
//            formVC.drID = dr3
//
//            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
//
//            self.show(homeVC, sender: (Any).self)
//
////            self.present(homeVC, animated: true, completion: nil)
//
//
//            homeVC.drID = idtxt.text
//        }
//
//        else {
//            idtxt.backgroundColor = .systemPink
//        }
//    }
//    //    @IBAction func next(_ sender: Any) {
//////        let dataDict = [
//////            "drid" : getDirectory() .absoluteString,
//////            "position" : position
//////        ]
////
//
////
////    }
//    @IBOutlet weak var idtxt: UITextField!
//
//
//    var dr1 = "1234"
//    var dr2 = "5678"
//    var dr3 = "9876"
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backBarButtonItem
//
//
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
