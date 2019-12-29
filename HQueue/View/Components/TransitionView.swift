//
//  TransitionView.swift
//  HQueue
//
//  Created by Faridho Luedfi on 13/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class TransitionView: UIView {
    @IBOutlet var content: UIView!
    
    @IBOutlet weak var imgTransition: UIImageView!
    @IBOutlet weak var titleTransition: UILabel!
    @IBOutlet weak var mesaggeTransition: UILabel!
    @IBOutlet weak var btnTransition: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    fileprivate func setupView() {
        self.backgroundColor = .purple
    }
    
    func showTransitionView(
        title: String,
        message: String,
        btnLabel: String = "Selesai",
        img: UIImage?
    ) {
        titleTransition.text = title
        mesaggeTransition.text = message
        btnTransition.setTitle(btnLabel, for: .normal)
        if let imgView = img {
            imgTransition.image = imgView
        }
        
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        
        keyWindow?.addSubview(content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func dismisAction(_ sender: Any) {
        removeFromSuperview()
    }
}
