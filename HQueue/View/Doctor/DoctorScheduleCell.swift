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
    @IBOutlet weak var view: UIView!
    
    override var isSelected: Bool {
        didSet {
            self.toggleSelectedHandler()
        }
    }
    
    func toggleSelectedHandler() {
        self.view.backgroundColor = self.isSelected ? .HQueueCream : .white
        self.timeLbl.textColor = self.isSelected ? .white : .HQueueYellow
        self.timeLbl.backgroundColor = self.isSelected ? .HQueueYellow : .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timeLbl.layer.borderColor = .HQueueYellow
        timeLbl.layer.borderWidth = 1
        timeLbl.layer.cornerRadius = 15
        view.layer.cornerRadius = 15
        timeLbl.layer.masksToBounds = true
        
        self.toggleSelectedHandler()
    }
}
