//
//  PatientDetail.swift
//  HQueue
//
//  Created by Faridho Luedfi on 14/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class PatientDetail: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    var patient: String!
    
    var isEdit = false
    
    var delegate: PatientList!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        // Setup Toolbar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissModal))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditState))
        
        // Fill form
        self.nameField.text = patient
        
    }
    
    @objc func dismissModal() {
        dismiss(animated: true) {
            self.delegate.items = [self.nameField.text] as! [String]
            self.delegate.tableView.reloadData()
        }
    }
    
    @objc func setEditState() {
        self.isEdit = true
        self.nameField.isEnabled = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDoneState))
    }
    
    @objc func setDoneState() {
        self.isEdit = false
         self.nameField.isEnabled = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
