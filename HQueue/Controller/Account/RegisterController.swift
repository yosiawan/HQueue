//
//  RegisterController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

struct firstRegisterPageData {
    var name: String
    var mother: String
    var gender: String
    var birthDate: String
    var bloodType: String
    var insurance: String
}

class RegisterController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var motherField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var bloodField: UITextField!
    @IBOutlet weak var insuranceField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftbarItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(self.dismissModal))
        self.navigationItem.leftBarButtonItem = leftbarItem
        
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func nextAction(_ sender: Any) {
        
        if motherField.text != "" &&
            nameField.text != "" &&
            genderField.text != "" &&
            birthField.text != "" &&
            bloodField.text != "" &&
            insuranceField.text != ""
        {
            let viewController = IdentityController()
            viewController.dataFromFirstPage = firstRegisterPageData(
                name: nameField.text ?? "No Value",
                mother: motherField.text ?? "No Value",
                gender: genderField.text ?? "No Value",
                birthDate: birthField.text ?? "No Value",
                bloodType: bloodField.text ?? "No Value",
                insurance: insuranceField.text ?? "No Value"
            )
            self.navigationController?.present(viewController, animated: true, completion: nil)
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
