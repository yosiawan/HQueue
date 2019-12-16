//
//  IdentityController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

struct secondRegisterPageData {
    var address: String
    var identityNumber: String
    var ktpImg: UIImage
}

class IdentityController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var dataFromFirstPage: firstRegisterPageData!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var identityNumberField: UITextField!
    @IBOutlet weak var ktpImg: UIImageView!
    
    var imgPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
    }

    @IBAction func nextAction(_ sender: Any) {
        
        if addressField.text != "" &&
            identityNumberField.text != "" &&
            ktpImg.image != nil
        {
            let vc = CredentialController()
            let vcWithNavCtrl = UINavigationController(rootViewController: vc)
            vc.dataFromSecondPage = secondRegisterPageData(
                address: addressField.text ?? "No value",
                identityNumber: identityNumberField.text ?? "No Value",
                ktpImg: ktpImg.image!
            )
            vc.dataFromFirstPage = self.dataFromFirstPage
            self.navigationController?.present(vcWithNavCtrl, animated: true, completion: nil)
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
    
    @IBAction func takePhoto(_ sender: Any) {
        imgPickerController =  UIImagePickerController()
        imgPickerController.delegate = self
        imgPickerController.sourceType = .camera

        present(imgPickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgPickerController.dismiss(animated: true, completion: nil)
        ktpImg.image = info[.originalImage] as? UIImage
    }
}
