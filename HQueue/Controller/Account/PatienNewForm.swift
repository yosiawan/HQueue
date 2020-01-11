//
//  PatienNewForm.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/01/20.
//  Copyright © 2020 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PatienNewForm: UIViewController {
    
    var networkManager: NetworkManager!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var identityNumberFields: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var motherNameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var bloodTypeField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var delegate: PatientList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        self.networkManager = NetworkManager()
        
        // Setup Toolbar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissModal))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData))
        
        // Setup Loading
        // todo gmana caranya disable semua button ketika loading
        self.loadingView.backgroundColor = .HQueueCreamSemiTransparant
        
        // Setup Selects
        setupGenderSelect()
        setupDOBSelect()
        setupBloodTypeSelect()
        
        notificationKeyboardObserver()
        hideKeyboarWhenTapView()
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true) {
            self.delegate.fetchData()
        }
    }
    
    func isValidForm() -> Bool {
        
        return (
            self.identityNumberFields.text != "" &&
            self.nameField.text != "" &&
            self.motherNameField.text != "" &&
            self.genderField.text != "" &&
            self.dobField.text != "" &&
            self.bloodTypeField.text != "" &&
            self.addressField.text != ""
        )
    }
    
    // MARK: Update Data Patient
    @objc func saveData() {
        DispatchQueue.main.async {
            self.loadingView.startAnimating()
        }
        
        guard self.isValidForm() else {
            DispatchQueue.main.async { self.loadingView.stopAnimating() }
            
            self.presentAlert(
                alert: .init(
                    title: "Validasi Form",
                    message: "Field tidak boleh kosong",
                    preferredStyle: .alert),
                actions: nil,
                comletion: nil)
            
            return
        }
        
        let newPatinet = Patient(
            fullName: nameField.text!,
            motherName: motherNameField.text!,
            identityNumber: identityNumberFields.text!,
            dob: dobField.text!,
            gender: genderField.text! == "Perempuan",
            bloodType: bloodTypeField.text!,
            address: addressField.text!,
            id: nil,
            photoIdentity: nil)
        
        self.networkManager.addPatient(patient: newPatinet) { (data, error) in
            if let error = error {
                
                DispatchQueue.main.async {
                    self.presentAlert(
                        alert: .init(
                            title: "Validasi",
                            message: error,
                            preferredStyle: .alert),
                        actions: nil,
                        comletion: nil)
                    self.loadingView.stopAnimating()
                }
            }
            
            if data != nil {
                DispatchQueue.main.async {
                    self.loadingView.stopAnimating()
                    self.dismissModal()
                }
            }
        }
        
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
    
    // MARK: DOB Select
    var selectDOB: UIDatePicker?
    var selectDOBPickerAccessory: UIToolbar?
    
    fileprivate func setupDOBSelect() {
        self.selectDOB = UIDatePicker()
        self.selectDOB?.datePickerMode = .date
        self.selectDOB?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.selectDOB?.backgroundColor = .white
        
        dobField.inputView = self.selectDOB
        
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
        
        dobField.inputAccessoryView = selectDOBPickerAccessory
    }
    
    @objc func doneBtnClickedSelectDOB(_ button: UIBarButtonItem?) {
        dobField.text = selectDOB?.date.changeToString(format: "YYYY-MM-dd")
        view.endEditing(true)
    }
    
    // MARK: Blood Type Select
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
        
        bloodTypeField.inputView = self.selectBloodType
        
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
        
        bloodTypeField.inputAccessoryView = selectBloodTypePickerAccessory
    }
    
    @objc func doneBtnClickedBloodType(_ button: UIBarButtonItem?) {
        bloodTypeField.text = selectBloodType?.selectedValue?.value
        view.endEditing(true)
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

}
