//
//  DoctorScheduleCell.swift
//  HQueue
//
//  Created by Yosia on 14/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorScheduleCell: UICollectionViewCell {
    var isActive: Bool = false
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var antrianLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        antrianLbl.textColor = .HQueueGreen
        titleLbl.textColor = .lightGray
        timeLbl.layer.cornerRadius = 25
        
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let constraints = [
//            self.contentView.heightAnchor.constraint(equalToConstant: 160),
//            self.contentView.widthAnchor.constraint(equalToConstant: 140),
//            self.heightAnchor.constraint(equalToConstant: 160),
//            self.widthAnchor.constraint(equalToConstant: 140)
//        ]
//        self.addConstraints(constraints)

        self.backgroundColor = .HQueueYellow
        self.layer.cornerRadius = 25
        
    }
    
    func changeState() {
        
    }
}
