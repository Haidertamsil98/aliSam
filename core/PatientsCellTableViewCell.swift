//
//  PatientsCellTableViewCell.swift
//  core
//
//  Created by Mac on 03/08/2023.
//  Copyright © 2023 Haider Tamsil. All rights reserved.
//

import UIKit

class PatientsCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        background.layer.cornerRadius = 12.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet var background: UIView!
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblAge: UILabel!
}
