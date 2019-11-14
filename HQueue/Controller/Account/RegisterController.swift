//
//  RegisterController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftbarItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(self.dismissModal))
        self.navigationItem.leftBarButtonItem = leftbarItem
        
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func nextAction(_ sender: Any) {
        let vc = IdentityController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
