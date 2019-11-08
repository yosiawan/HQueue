//
//  QueueControllerViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class QueueController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "QueueView", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Queue"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let rightBarButton = UIBarButtonItem(title: "Account", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.pushToAccount))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func pushToAccount() {
        let loginVC = AccountController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
