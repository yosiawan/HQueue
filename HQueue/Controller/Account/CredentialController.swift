//
//  CredentialController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class CredentialController: UIViewController {
    
    var dataFromFirstPage: firstRegisterPageData!
    var dataFromSecondPage: secondRegisterPageData!
    var networkManager: NetworkManager!

    @IBOutlet weak var phoneNumField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkManager()
        
        self.isModalInPresentation = true
        let rightBarButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(self.submit(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    @IBAction func submit(_ sender: Any) {
        if phoneNumField.text != "" &&
            emailField.text != "" &&
            passField.text != "" &&
            confirmPassField.text == passField.text
        {
            // SUBMIT HERE
            let newAuth = HQAuth(
                name: dataFromFirstPage.name,
                email: emailField.text ?? "No Value",
                token: nil,
                phoneNumber: phoneNumField.text ?? "No Value"
            )
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dataPatient = Patient(
                fullName: dataFromFirstPage.name,
                motherName: dataFromFirstPage.mother,
                identityNumber: dataFromSecondPage.identityNumber,
                dob: dataFromFirstPage.birthDate,
                gender: true,
                address: dataFromSecondPage.address,
                id: nil
            )
            networkManager.sigupAndCretePatient(
                newAuth: newAuth,
                newPass: passField.text!,
                patientData: dataPatient
            ) { (auth, error) in
                if let auth = auth {
                    // do something with new User data
                    print("Success ", auth)
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(
                            title: "Registrasi Sukses",
                            message: error,
                            preferredStyle: .alert
                        )
                        let tutup = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in }
                        alertController.addAction(tutup)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
                if let error = error {
                    print("Error ", error)
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(
                            title: "Registrasi Gagal",
                            message: error,
                            preferredStyle: .alert
                        )
                        let tutup = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in }
                        alertController.addAction(tutup)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
            let alertController = UIAlertController(
                title: "Form Belum Lengkap",
                message: "Mohon lengkapi formulir sebelum melanjutkan registrasi.",
                preferredStyle: .alert
            )
            let tutup = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in }
            alertController.addAction(tutup)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
