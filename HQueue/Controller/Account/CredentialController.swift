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
        let rightBarButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(self.doneAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func doneAction() {
        let newAuth = HQAuth(name: "Adi", email: "faridho@roketdigital.com", token: nil, phoneNumber: "089777872")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dob = formatter.date(from: "2016-10-08")
        let dataPatient = Patient(fullName: "faridho luedfi", motherName: "Siti", identityNumber: "3338999231", dob: "2016-10-08", gender: true, address: "Jl. Cempaka", id: nil)
        networkManager.sigupAndCretePatient(newAuth: newAuth, newPass: "galileogaleli", patientData: dataPatient) { (auth, error) in
            if let error = error {
                print(error)
            }
            if let auth = auth {
                print(auth)
            }
        }
        
        //dismiss(animated: true, completion: nil)
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
            let dob = formatter.date(from: "2016-10-08")
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
                if let error = error {
                    print(error)
                }
                if let auth = auth {
                    print(auth)
                }
            }
        }
    }
}
