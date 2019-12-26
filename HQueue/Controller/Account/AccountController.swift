//
//  AccountController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit
import LocalAuthentication

class AccountController: UIViewController {
    
    var networkManager: NetworkManager!
    var profile: HUser?
    
   

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
        
        self.networkManager = NetworkManager()
        
        if self.isLogged() {
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
        
        if self.isLogged() {
            self.view = loggedView
            self.fetchingData()
            self.nameField.text = self.profile?.name
            self.emailField.text = self.profile?.email
            self.phoneNumberField.text = self.profile?.phoneNumber
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
        vc.navigationBar.isTranslucent = false
        vc.view.backgroundColor = .white
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signinAction(_ sender: Any) {
        let vc = Login()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toPatientList(_ sender: Any) {
        
        self.checkBiometricAuth { (success) in
            if success {
                DispatchQueue.main.async {
                    let vc = PatientList()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                print(#function, "false")
            }
        }
    
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.setIsLogout()
        self.navigationItem.setRightBarButton(nil, animated: false)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func fetchingData() {
        self.networkManager.getProfile { (data, error) in
            if error != nil {
                //print("Account - get profile", error)
            }
            if let data = data {
                self.profile = data
            }
        }
    }
    
    // Biometric Auth
    @objc func checkBiometricAuth(_ completion: @escaping(_ isSuccess: Bool )->()) {
        
        let localAuth = LAContext()
        localAuth.localizedFallbackTitle = "Please use your Passcode"
        
        var authError: NSError?
        let reseon = "Authenticate is required for you to continue"
        
        if localAuth.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &authError) {
            
            let biometricType = localAuth.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            print("Biometric Type: \(biometricType)")
            
            localAuth.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reseon) { (success, error) in
        
                completion(success)

            }
            
        } else {
            print("Biometric isnt supported")
        }
    }
       
}
