//
//  TransitionView.swift
//  HQueue
//
//  Created by Faridho Luedfi on 13/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class TransitionView: UIView {
    
    let transitionImg = UIImageView()
    let transitionTitleLabel = UILabel()
    let transitionMessageLabel = UILabel()
    let trasitionBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    fileprivate func setupView() {
        self.backgroundColor = .purple
    }
    
    func wekeupView(target: UIViewController, title: String, message: String?, btnLabel: String? ) {
        
        target.view.addSubview(self)
        self.leadingAnchor.constraint(equalTo: target.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: target.view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: target.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: target.view.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
