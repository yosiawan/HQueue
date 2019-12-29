//
//  IdentityController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class IdentityController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var patient: Patient!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var identityNumberField: UITextField!
    @IBOutlet weak var ktpImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imgPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: view.frame.height)
        
        self.isModalInPresentation = true
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
    }

    @IBAction func nextAction(_ sender: Any) {
        
        if addressField.text != "" &&
            addressField.text!.count >= 15 &&
            identityNumberField.text != "" &&
            ktpImg.image != nil
        {
            let vc = CredentialController()
            vc.patient = self.patient
            vc.patient.address = addressField.text!
            vc.patient.identityNumber = identityNumberField.text!
            self.navigationController?.pushViewController(vc, animated: true)
        } else if addressField.text!.count < 15  {
            
            let alertController = UIAlertController(
                title: "Alamat belum lengkap",
                message: "Minimal karakter 15, untuk alamat",
                preferredStyle: .alert
            )
            let tutup = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in }
            alertController.addAction(tutup)
            self.present(alertController, animated: true, completion: nil)
        
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
