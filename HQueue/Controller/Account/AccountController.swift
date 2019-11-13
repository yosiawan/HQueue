//
//  AccountController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class AccountController: UIViewController {
    
    var isLoggged = false

    @IBOutlet var loggedView: UIView!
    @IBOutlet var guestView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (isLoggged){
            self.view = loggedView
        }else{
            self.view = guestView
            self.navigationController?.navigationItem.title = "Account"
        }
       
    }

    @IBAction func signupAction(_ sender: Any) {
        let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signinAction(_ sender: Any) {
        let vc = Login()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
