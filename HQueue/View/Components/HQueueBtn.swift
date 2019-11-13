//
//  TimeLabel.swift
//  HQueue
//
//  Created by Yosia on 11/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HQueueBtn: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isActive: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 25
        self.view.backgroundColor = .white
        self.timeLabel.textColor = .HQueueYellow
    }
    
    func changeColor() -> Void {
        if isActive {
            self.view.backgroundColor = .HQueueYellow
            self.timeLabel.textColor = .white
            return
        }
        
        self.view.backgroundColor = .white
        self.timeLabel.textColor = .HQueueYellow
        return
    }
}
