//
//  ForgotPass.swift
//  HQueue
//
//  Created by Yosia on 18/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension ForgotPass {
    
    func setConstraints() -> Void {
        var constraints = [NSLayoutConstraint]()

        self.view.backgroundColor = .white
        
        // MARK: - Header
        self.view.addSubview(header)
        header.image = UIImage(named: "pablo-augmented-reality")
        header.translatesAutoresizingMaskIntoConstraints = false
        let headerConstraints = [
            header.heightAnchor.constraint(equalToConstant: 232),
            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ]
        constraints.append(contentsOf: headerConstraints)
        
        // MARK: - Title
        strLabel.text = "Kami akan mengirimkan pesan ke email Anda untuk mereset password Anda"
        self.view.addSubview(strLabel)
        strLabel.textAlignment = .center
        strLabel.numberOfLines = 4
        strLabel.font = UIFont.boldSystemFont(ofSize: 22)
        strLabel.translatesAutoresizingMaskIntoConstraints = false
        let strLabelConstraints = [
            strLabel.widthAnchor.constraint(equalToConstant: 252),
            strLabel.heightAnchor.constraint(equalToConstant: 120),
            strLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            strLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ]
        constraints.append(contentsOf: strLabelConstraints)
        
        // MARK: - Icon
        self.view.addSubview(fieldIcon)
        fieldIcon.translatesAutoresizingMaskIntoConstraints = false
        fieldIcon.image = UIImage(named: "icons8-employee_card")
        let fieldIconConstraints = [
            fieldIcon.topAnchor.constraint(equalTo: strLabel.bottomAnchor, constant: 40),
            fieldIcon.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            fieldIcon.heightAnchor.constraint(equalToConstant: 38),
            fieldIcon.widthAnchor.constraint(equalToConstant: 30)
        ]
        constraints.append(contentsOf: fieldIconConstraints)
        
        // MARK: - Email Field
        self.view.addSubview(emailField)
        emailField.placeholder = "Email"
        emailField.translatesAutoresizingMaskIntoConstraints = false
        let emailFieldConstraints = [
            emailField.heightAnchor.constraint(equalToConstant: 38),
            emailField.topAnchor.constraint(equalTo: strLabel.bottomAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: fieldIcon.trailingAnchor, constant: 10)
        ]
        constraints.append(contentsOf: emailFieldConstraints)

        // MARK: - Underline
        self.view.addSubview(underline)
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .HQueueYellow
        let underlineConstraints = [
            underline.topAnchor.constraint(equalTo: fieldIcon.bottomAnchor, constant: 10),
            underline.widthAnchor.constraint(equalToConstant: 370),
            underline.heightAnchor.constraint(equalToConstant: 1),
            underline.leadingAnchor.constraint(equalTo: fieldIcon.leadingAnchor)
        ]
        constraints.append(contentsOf: underlineConstraints)
        
        // MARK: - Submit Button
        submitBtn.backgroundColor = .blue
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.titleLabel?.textColor = .white
        submitBtn.layer.cornerRadius = 23
        submitBtn.layer.masksToBounds = true
        self.view.addSubview(submitBtn)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        let submitBtnConstraints = [
            submitBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 80),
            submitBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            submitBtn.heightAnchor.constraint(equalToConstant: 46),
            submitBtn.widthAnchor.constraint(equalToConstant: 174)
        ]
        constraints.append(contentsOf: submitBtnConstraints)
        NSLayoutConstraint.activate(constraints)
    }
}
