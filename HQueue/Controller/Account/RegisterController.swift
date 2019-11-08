//
//  RegisterController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var nameField: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func nextAction(_ sender: Any) {
        let vc = IdentityController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
