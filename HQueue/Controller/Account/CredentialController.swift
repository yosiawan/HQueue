//
//  CredentialController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class CredentialController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        let rightBarButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(self.doneAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func doneAction() {
        dismiss(animated: true, completion: nil)
    }
    
}
