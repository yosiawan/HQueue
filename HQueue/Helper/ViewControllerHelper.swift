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
    
    func presetAlert(alert: UIAlertController, actions: [UIAlertAction]?, comletion: (() -> ())?) {
        
        // Add actions
        if let actions: [UIAlertAction] = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(.init(title: "Tutup", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true, completion: comletion)
    }
}
