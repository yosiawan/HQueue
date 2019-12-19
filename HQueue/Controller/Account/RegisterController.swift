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
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectGender: DropDownPicker?
    var pickerAccessory: UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectGender = DropDownPicker()
        self.selectGender?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.selectGender?.backgroundColor = .white
        self.selectGender?.data = [SelectValue(key: "laki-laki", value: "Laki - laki"), SelectValue(key: "perempuan", value: "Perempuan")]
        
        genderField.inputView = self.selectGender
        
        pickerAccessory = UIToolbar()
        pickerAccessory?.autoresizingMask = .flexibleHeight
        
        pickerAccessory?.barStyle = .default
        pickerAccessory?.barTintColor = .systemGray5
        pickerAccessory?.backgroundColor = .systemGray5
        pickerAccessory?.isTranslucent = false
        
        var frame = pickerAccessory?.frame
        frame?.size.height = 44
        pickerAccessory?.frame = frame!
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //a flexible space between the two buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked(_:)))
        doneButton.tintColor = .HQueueDarkBlue

        //Add the items to the toolbar
        pickerAccessory?.items = [flexSpace, doneButton]
        
        genderField.inputAccessoryView = pickerAccessory
        
        //TODO: Localitaion Bahasa
        let leftbarItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(self.dismissModal))
        self.navigationItem.leftBarButtonItem = leftbarItem
        
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
        
        notificationKeyboardObserver()
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        
        genderField.text = selectGender?.selectedValue?.value
    }
    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func notificationKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWhilAction(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWhilAction(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWhilAction(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        print(userInfo)
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
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
            let vcWithNavCtrl = UINavigationController(rootViewController: viewController)
            viewController.dataFromFirstPage = firstRegisterPageData(
                name: nameField.text ?? "No Value",
                mother: motherField.text ?? "No Value",
                gender: genderField.text ?? "No Value",
                birthDate: birthField.text ?? "No Value",
                bloodType: bloodField.text ?? "No Value",
                insurance: insuranceField.text ?? "No Value"
            )
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
}
