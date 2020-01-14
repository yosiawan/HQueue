//
//  HospitalCell.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HospitalCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var imageHospital: UIImageView!
    @IBOutlet weak var detailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageHospital.layer.cornerRadius = imageHospital.frame.width / 2
        detailView.layer.cornerRadius = 15
        
        self.selectionStyle = .none
    }
    
    func resetView() {
        self.imageHospital.image = #imageLiteral(resourceName: "hospital-list-default-img")
    }
    
    func setHospitalCard(_ hospital: Hospital) {
        self.titleLabel.text = hospital.name
        self.addressLabel.text = hospital.address
        if let imgUrlString = hospital.photo {
            self.imageHospital.downloaded(from: imgUrlString)
            self.imageHospital.contentMode = .scaleAspectFill
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
