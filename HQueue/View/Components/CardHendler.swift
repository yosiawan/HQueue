//
//  CardHendler.swift
//  HQueue
//
//  Created by Faridho Luedfi on 08/01/20.
//  Copyright © 2020 Apple Dev. Academy. All rights reserved.
//

import UIKit

class CardHendlerContent: UIView {
    
    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: -6.0)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 4

            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }

}
