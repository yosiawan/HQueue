//
//  File.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setTransparantNav() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func hideKeyboarWhenTapView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gesture:)))
        view?.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(gesture: UITapGestureRecognizer) {
        view?.endEditing(true)
    }
    
}
