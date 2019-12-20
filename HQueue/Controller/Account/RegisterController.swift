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
    //var insurance: String
}

class RegisterController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var motherField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var bloodField: UITextField!
    @IBOutlet weak var insuranceField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: view.frame.height)
        
        setupGenderSelect()
        setupDOBSelect()
        setupBloodTypeSelect()
        
        setupNavigation()
        
        notificationKeyboardObserver()
    }
    
    // MARK: Gender Select
    
    var selectGender: DropDownPicker?
    var selectGenderPickerAccessory: UIToolbar?
    
    fileprivate func setupGenderSelect() {
        self.selectGender = DropDownPicker()
        self.selectGender?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.selectGender?.backgroundColor = .white
        self.selectGender?.data = [SelectValue(key: "laki-laki", value: "Laki - laki"), SelectValue(key: "perempuan", value: "Perempuan")]
        
        genderField.inputView = self.selectGender
        
        selectGenderPickerAccessory = UIToolbar()
        selectGenderPickerAccessory?.autoresizingMask = .flexibleHeight
        
        selectGenderPickerAccessory?.barStyle = .default
        selectGenderPickerAccessory?.barTintColor = .systemGray5
        selectGenderPickerAccessory?.backgroundColor = .systemGray5
        selectGenderPickerAccessory?.isTranslucent = false
        
        var frame = selectGenderPickerAccessory?.frame
        frame?.size.height = 44
        selectGenderPickerAccessory?.frame = frame!
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //a flexible space between the two buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClickedGenderSelect(_:)))
        doneButton.tintColor = .HQueueDarkBlue
        
        //Add the items to the toolbar
        selectGenderPickerAccessory?.items = [flexSpace, doneButton]
        
        genderField.inputAccessoryView = selectGenderPickerAccessory
    }
    
    @objc func doneBtnClickedGenderSelect(_ button: UIBarButtonItem?) {
        genderField.text = selectGender?.selectedValue?.value
        view.endEditing(true)
    }
    
    // MARK: Gender Select
    
    var selectDOB: UIDatePicker?
    var selectDOBPickerAccessory: UIToolbar?
    
    fileprivate func setupDOBSelect() {
        self.selectDOB = UIDatePicker()
        self.selectDOB?.datePickerMode = .date
        self.selectDOB?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.selectDOB?.backgroundColor = .white
        
        birthField.inputView = self.selectDOB
        
        selectDOBPickerAccessory = UIToolbar()
        selectDOBPickerAccessory?.autoresizingMask = .flexibleHeight
        
        selectDOBPickerAccessory?.barStyle = .default
        selectDOBPickerAccessory?.barTintColor = .systemGray5
        selectDOBPickerAccessory?.backgroundColor = .systemGray5
        selectDOBPickerAccessory?.isTranslucent = false
        
        var frame = selectDOBPickerAccessory?.frame
        frame?.size.height = 44
        selectDOBPickerAccessory?.frame = frame!
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //a flexible space between the two buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClickedSelectDOB(_:)))
        doneButton.tintColor = .HQueueDarkBlue
        
        //Add the items to the toolbar
        selectDOBPickerAccessory?.items = [flexSpace, doneButton]
        
        birthField.inputAccessoryView = selectDOBPickerAccessory
    }
    
    @objc func doneBtnClickedSelectDOB(_ button: UIBarButtonItem?) {
        birthField.text = selectDOB?.date.changeToString(format: "YYYY-MM-dd")
        view.endEditing(true)
    }
    
    // MARK: Gender Select
    
    var selectBloodType: DropDownPicker?
    var selectBloodTypePickerAccessory: UIToolbar?
    
    fileprivate func setupBloodTypeSelect() {
        self.selectBloodType = DropDownPicker()
        self.selectBloodType?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.selectBloodType?.backgroundColor = .white
        self.selectBloodType?.data = [
            SelectValue(key: "o", value: "O"),
            SelectValue(key: "b", value: "B"),
            SelectValue(key: "a", value: "A"),
            SelectValue(key: "ab", value: "AB"),
        ]
        
        bloodField.inputView = self.selectBloodType
        
        selectBloodTypePickerAccessory = UIToolbar()
        selectBloodTypePickerAccessory?.autoresizingMask = .flexibleHeight
        
        selectBloodTypePickerAccessory?.barStyle = .default
        selectBloodTypePickerAccessory?.barTintColor = .systemGray5
        selectBloodTypePickerAccessory?.backgroundColor = .systemGray5
        selectBloodTypePickerAccessory?.isTranslucent = false
        
        var frame = selectBloodTypePickerAccessory?.frame
        frame?.size.height = 44
        selectBloodTypePickerAccessory?.frame = frame!
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //a flexible space between the two buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClickedBloodType(_:)))
        doneButton.tintColor = .HQueueDarkBlue
        
        //Add the items to the toolbar
        selectBloodTypePickerAccessory?.items = [flexSpace, doneButton]
        
        bloodField.inputAccessoryView = selectBloodTypePickerAccessory
    }
    
    @objc func doneBtnClickedBloodType(_ button: UIBarButtonItem?) {
        bloodField.text = selectBloodType?.selectedValue?.value
        view.endEditing(true)
    }
    
    // MARK: Modal Navigation
    fileprivate func setupNavigation() {
        //TODO: Localitaion Bahasa
        let leftbarItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(self.dismissModal))
        self.navigationItem.leftBarButtonItem = leftbarItem
        
        let rightBarButton = UIBarButtonItem(title: "Lanjut", style: .plain, target: self, action: #selector(self.nextAction))
        
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    // dismis modal
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Keyboard action
    func notificationKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWhilAction(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWhilAction(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWhilAction(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
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
            bloodField.text != ""
            //insuranceField.text != ""
        {
            let viewController = IdentityController()
//            let vcWithNavCtrl = UINavigationController(rootViewController: viewController)
            viewController.dataFromFirstPage = firstRegisterPageData(
                name: nameField.text ?? "No Value",
                mother: motherField.text ?? "No Value",
                gender: genderField.text ?? "No Value",
                birthDate: birthField.text ?? "No Value",
                bloodType: bloodField.text ?? "No Value"
                //insurance: insuranceField.text ?? "No Value"
            )
            self.navigationController?.pushViewController(viewController, animated: true)
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
