//
//  IdentityController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class IdentityController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextAction(_ sender: Any) {
        let vc = CredentialController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
