//
//  QueueArea.swift
//  HQueue
//
//  Created by Bill Tanthowi Jauhari on 11/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class QueueArea: UIView {
    
    private let radius: CGFloat = 40
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        self.layer.cornerRadius = radius
        self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -10, height: -10)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
