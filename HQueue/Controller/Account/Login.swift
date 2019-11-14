//
//  Login.swift
//  HQueue
//
//  Created by Yosia on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class Login: UIViewController {
    
    var networkManager: NetworkManager!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        // Do any additional setup after loading the view.
    }
    
    func activityIndicator(_ title: String) {

        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()

        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)

        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true

        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()

        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.effectView.removeFromSuperview()
        }
    }
    
    func presetAlert(text: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Daftar", message: text, preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
      
    }
    
    @IBAction func loginAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.activityIndicator("Loading")
        }
        
        print([emailField.text!, passwordField.text!])
        
        networkManager.login(email: emailField.text!, password: passwordField.text!) { (auth: HQAuth?, error) in
            self.stopActivityIndicator()
            if let error = error {
                self.presetAlert(text: error)
            }
            if let auth = auth {
                UserDefaults.standard.set(auth.name, forKey: "authName")
                UserDefaults.standard.set(auth.email, forKey: "authEmail")
                UserDefaults.standard.set(auth.token, forKey: "authToken")
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let vc = UINavigationController(rootViewController: RegisterController())
        vc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc.navigationBar.shadowImage = UIImage()
        vc.navigationBar.isTranslucent = true
        vc.view.backgroundColor = .clear
        self.present(vc, animated: true, completion: nil)
    }
}
