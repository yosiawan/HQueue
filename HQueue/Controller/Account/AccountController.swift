//
//  AccountController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class AccountController: UIViewController {

    @IBOutlet var loggedView: UIView!
    @IBOutlet var guestView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogged()
    }
    
    fileprivate func checkLogged() {
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            self.view = loggedView
        }else{
            self.view = guestView
            self.navigationController?.navigationItem.title = "Account"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLogged()
       
    }

    @IBAction func signupAction(_ sender: Any) {
        let vc = UINavigationController(rootViewController: RegisterController())
        vc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc.navigationBar.shadowImage = UIImage()
        vc.navigationBar.isTranslucent = true
        vc.view.backgroundColor = .clear
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func signinAction(_ sender: Any) {
        let vc = Login()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "authName")
        UserDefaults.standard.removeObject(forKey: "authEmail")
        UserDefaults.standard.removeObject(forKey: "authToken")
        self.navigationController?.popToRootViewController(animated: true)
    }
}
