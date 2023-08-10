//
//  LearningViewController.swift
//  core
//
//  Created by Mac on 09/08/2023.
//  Copyright © 2023 Haider Tamsil. All rights reserved.
//

import UIKit

class LearningViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    let modules = ["Heart", "Lungs"]
    let ModImages = ["heartMod","lungsMod"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moduleTbl.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ModulesCell
        cell.moduleName?.text = modules[indexPath.row]
        cell.ModuleImage?.image = UIImage(named: ModImages[indexPath.row])
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        moduleTbl.rowHeight = 217
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet var moduleTbl: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
