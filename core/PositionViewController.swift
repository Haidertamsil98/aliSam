//
//  PositionViewController.swift
//  core
//
//  Created by Apple on 27/04/2021.
//  Copyright © 2021 HaiderTamsil. All rights reserved.
//

import UIKit
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


class PositionViewController: UIViewController {
    var record = recordViewController()

    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet var sittingBtnOutlet: UIButton!
    
    @IBOutlet var LyingButtonOutlet: UIButton!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func SittingBtn(_ sender: Any) {
        
        label?.text = "Sitting"
        
        sittingBtnOutlet.borderColor = .black
        LyingButtonOutlet.borderColor = .clear
        
        
       
        
    }
    
    
    @IBAction func lying(_ sender: Any) {
        label?.text = "Lying"
        
        sittingBtnOutlet.borderColor = .clear
        LyingButtonOutlet.borderColor = .black
        
    }
    
    
    
    
    @IBAction func next(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name("text2"), object: label.text)
          dismiss(animated:true, completion: nil)
        
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
