//
//  PoliCell.swift
//  HQueue
//
//  Created by Faridho Luedfi on 17/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PoliCell: UITableViewCell {
    
    @IBOutlet weak var poliView: UIView!
    @IBOutlet weak var poliNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        poliView.layer.cornerRadius = 15
        
        self.selectionStyle = .none
    }
    
    func setPoli(poli: Poli) {
        self.poliNameLabel.text = poli.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = .clear
    }
}
