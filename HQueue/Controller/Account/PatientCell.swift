//
//  PatientCell.swift
//  HQueue
//
//  Created by Faridho Luedfi on 13/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PatientCell: UITableViewCell {
    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var patientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialView.layer.cornerRadius = initialView.frame.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
