//
//  CollectionViewCell.swift
//  HQueue
//
//  Created by Yosia on 13/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class InsuranceCell: UICollectionViewCell {

    @IBOutlet weak var insuranceImg: UIImageView!
    override var isSelected: Bool {
        didSet {
            self.contentView.layer.borderWidth = 1
            self.contentView.layer.borderColor = self.isSelected ? .HQueueYellow : .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.layer.cornerRadius = 25

        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 72).isActive = true
        self.widthAnchor.constraint(equalToConstant: 72).isActive = true
        
        insuranceImg.translatesAutoresizingMaskIntoConstraints = false
        insuranceImg.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        insuranceImg.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        insuranceImg.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        insuranceImg.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        insuranceImg.heightAnchor.constraint(equalToConstant: 72).isActive = true
        insuranceImg.widthAnchor.constraint(equalToConstant: 72).isActive = true
        
        insuranceImg.contentMode = .scaleAspectFit
        
    }
}
