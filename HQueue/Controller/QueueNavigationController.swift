//
//  QueueNavigationController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 16/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class QueueNavigationController: UINavigationController {
    
    var queueNavigationDelegate: QueueNavigationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = .HQueueDarkBlue
        // Do any additional setup after loading the view.
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}

protocol QueueNavigationControllerDelegate {
    func didRegisterQueue()
}


