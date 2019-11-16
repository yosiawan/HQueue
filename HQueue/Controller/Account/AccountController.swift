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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dataPatientTrigger: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            let editBarItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editProfileAction))
            self.navigationItem.setRightBarButton(editBarItem, animated: false)
        }
        
        setupView()
    }
    
    @objc func editProfileAction() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editProfileActionDone))
        nameField.isEnabled = true
        emailField.isEnabled = true
        phoneNumberField.isEnabled = true
    }
    
    @objc func editProfileActionDone() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editProfileAction))
        nameField.isEnabled = false
        emailField.isEnabled = false
        phoneNumberField.isEnabled = false
    }
    
    fileprivate func setupView() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        dataPatientTrigger.layer.cornerRadius = 15
        dataPatientTrigger.layer.borderColor = #colorLiteral(red: 1, green: 0.6567588449, blue: 0, alpha: 1)
        dataPatientTrigger.layer.borderWidth = 1
        
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            self.view = loggedView
        }else{
            self.view = guestView
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupView()
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
    
    @IBAction func toPatientList(_ sender: Any) {
        let vc = PatientList()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "authName")
        UserDefaults.standard.removeObject(forKey: "authEmail")
        UserDefaults.standard.removeObject(forKey: "authToken")
        self.navigationItem.setRightBarButton(nil, animated: false)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
