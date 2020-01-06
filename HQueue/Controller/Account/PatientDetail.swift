//
//  PatientDetail.swift
//  HQueue
//
//  Created by Faridho Luedfi on 14/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PatientDetail: UIViewController {
    
    @IBOutlet var fieldGroups: [UITextField]!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var motherNameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var bloodTypeField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var patient: Patient!
    
    var isEdit = false
    
    var delegate: PatientList!

    fileprivate func fillForm() {
        // Fill form
        self.nameField.text = patient.fullName
        self.motherNameField.text = patient.motherName
        //self.phoneField.text =
        self.genderField.text = patient.getGenderString()
        self.dobField.text = patient.dob
        self.bloodTypeField.text = patient.bloodType
        self.addressField.text = patient.address
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        // Setup Toolbar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissModal))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditState))
        
        fillForm()
        
        // Setup Selects
        setupGenderSelect()
        setupDOBSelect()
        setupBloodTypeSelect()
        
        notificationKeyboardObserver()
        hideKeyboarWhenTapView()
    }
    
    func isChangeData() -> Bool {
        return (
        self.nameField.text != patient.fullName ||
        self.motherNameField.text != patient.motherName ||
        //self.phoneField.text =
        self.genderField.text != patient.getGenderString() ||
        self.dobField.text != patient.dob ||
        self.bloodTypeField.text != patient.bloodType ||
            self.addressField.text != patient.address
        )
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true)
    }
    
    @objc func willCancelEditing() -> Void {
        if isChangeData() {
            return self.presentAlert(
                alert: .init(title: "Abaikan perubahan?", message: nil, preferredStyle: .actionSheet),
                actions: [
                    .init(title: "Batalkan Perubahan", style: .destructive, handler: { (action) in
                        self.fillForm()
                        self.didCancleTheChanges()
                    }),
                    .init(title: "Lanjutkan Perubahan", style: .cancel, handler: nil),
                    
            ], comletion: nil)
        }
        return self.didCancleTheChanges()
    }
    
    func didCancleTheChanges() {
        self.setDefaultState()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.setEditState))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.dismissModal))
    }
    
    @objc func setEditState() {
        self.isEdit = true
        self.nameField.isEnabled = true
        self.phoneField.isEnabled = true
        self.motherNameField.isEnabled = true
        self.genderField.isEnabled = true
        self.dobField.isEnabled = true
        self.bloodTypeField.isEnabled = true
        self.addressField.isEnabled = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDoneState))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(willCancelEditing))
        self.nameField.becomeFirstResponder()
    }
    
    @objc func setDefaultState() {
        self.isEdit = false
        self.nameField.isEnabled = false
        self.phoneField.isEnabled = false
        self.motherNameField.isEnabled = false
        self.genderField.isEnabled = false
        self.dobField.isEnabled = false
        self.bloodTypeField.isEnabled = false
        self.addressField.isEnabled = false
    }
    
    @objc func setDoneState() {
        //
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
