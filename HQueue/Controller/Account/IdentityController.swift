//
//  IdentityController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class IdentityController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ktpImg: UIImageView!
    var imgPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
    }

    @IBAction func nextAction(_ sender: Any) {
        let vc = CredentialController()
        self.navigationController?.pushViewController(vc, animated: true)
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
