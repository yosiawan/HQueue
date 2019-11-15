//
//  QueueControllerViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class QueueController: UIViewController {
    
    @IBOutlet weak var wellcomeLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "QueueView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Queue"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let rightBarButton = UIBarButtonItem(title: "Account", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.pushToAccount))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        checkLogged()
    }
    
    fileprivate func checkLogged() {
        if let name = UserDefaults.standard.string(forKey: "authName") {
            wellcomeLabel.isHidden = false
            wellcomeLabel.text = "Hello, \(name)"
        }else{
            wellcomeLabel.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkLogged()
    }
    
    @objc func pushToAccount() {
//        let loginVC = AccountController()
//        self.navigationController?.pushViewController(loginVC, animated: true)
        let vc = HospitalList()
        let nv = UINavigationController(rootViewController: vc)
        self.present(nv, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
