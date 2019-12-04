//
//  AccountThumbnail.swift
//  HQueue
//
//  Created by Bill Tanthowi Jauhari on 11/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class AccountThumbnail: UIView {

    @IBOutlet weak var initialName: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func didMoveToSuperview() {
        self.initialName.layer.cornerRadius = self.initialName.frame.height / 2
        self.initialName.layer.masksToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
