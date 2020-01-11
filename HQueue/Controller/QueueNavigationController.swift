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

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = .HQueueDarkBlue
        self.navigationBar.barTintColor = .white
        // Do any additional setup after loading the view.
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol QueueNavigationControllerDelegate {
    func didRegisterQueue()
}


