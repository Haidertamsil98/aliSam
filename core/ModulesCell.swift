//
//  ModulesCell.swift
//  core
//
//  Created by Mac on 09/08/2023.
//  Copyright © 2023 Haider Tamsil. All rights reserved.
//

import UIKit

class ModulesCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backGround.layer.cornerRadius = 12.5
        addShadow()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func addShadow(){
        
        

                // Apply shadow properties to the background container
                backGround.layer.shadowColor = UIColor.black.cgColor
                backGround.layer.shadowOpacity = 0.1
                backGround.layer.shadowOffset = CGSize(width: 0, height: 8)
                backGround.layer.shadowRadius = 4

                // Adjust the shadow path for better performance
               
    }

    @IBOutlet var backGround: UIView!
    @IBOutlet var moduleName: UILabel!
    @IBOutlet var ModuleImage: UIImageView!
}
