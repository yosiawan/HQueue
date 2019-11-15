//
//  CredentialController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class CredentialController: UIViewController {
    
    var networkManager: NetworkManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkManager()
        
        self.isModalInPresentation = true
        let rightBarButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(self.doneAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func doneAction() {
        let newAuth = HQAuth(name: "Adi", phoneNumber: "0897776634", email: "faridho+4@roketdigital.com", token: "")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dob = formatter.date(from: "2016-10-08")
        let dataPatient = Patient(fullName: "faridho luedfi", motherName: "Siti", identityNumber: "3338999231", dob: dob!, gender: 1, address: "Jl. Cempaka")
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
    
}