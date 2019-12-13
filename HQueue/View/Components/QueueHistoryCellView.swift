//
//  QueueHistoryCellView.swift
//  HQueue
//
//  Created by Yosia on 11/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension QueueHistoryCell {
    
    func setConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        backgroundBox.layer.cornerRadius = 15
        backgroundBox.layer.masksToBounds = true
        backgroundBox.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 1)
        self.contentView.addSubview(backgroundBox)
        backgroundBox.translatesAutoresizingMaskIntoConstraints = false
        let backgroundBoxConstraints = [
            backgroundBox.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(25)),
            backgroundBox.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(0)),
            backgroundBox.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: CGFloat(12)),
            backgroundBox.heightAnchor.constraint(equalToConstant: CGFloat(130)),
            backgroundBox.widthAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.widthAnchor, constant: CGFloat(-25))
        ]
        constraints.append(contentsOf: backgroundBoxConstraints)
        
        hospitalName.text = "RS Fairdha"
        hospitalName.textColor = .HQueueYellow
        hospitalName.font = UIFont.boldSystemFont(ofSize: 17)
        self.contentView.addSubview(hospitalName)
        hospitalName.translatesAutoresizingMaskIntoConstraints = false
        let hospitalNameConstraints = [
            hospitalName.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 15),
            hospitalName.topAnchor.constraint(equalTo: backgroundBox.safeAreaLayoutGuide.topAnchor, constant: 15)
        ]
        constraints.append(contentsOf: hospitalNameConstraints)
        
        dateLbl.text = "99/99/9999"
        dateLbl.textColor = .HQueueGreyFont
        dateLbl.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(dateLbl)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        let dateLblConstraints = [
            dateLbl.topAnchor.constraint(equalTo: backgroundBox.topAnchor, constant: 15),
            dateLbl.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -15)
        ]
        constraints.append(contentsOf: dateLblConstraints)
        
        poliName.textColor = .HQueueGreyFont
        poliName.text = "Spesialis Anak"
        poliName.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(poliName)
        poliName.translatesAutoresizingMaskIntoConstraints = false
        let poliNameConstraints = [
            poliName.topAnchor.constraint(equalTo: hospitalName.bottomAnchor, constant: 5),
            poliName.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 15),
        ]
        constraints.append(contentsOf: poliNameConstraints)
        
        doctorName.textColor = .HQueueGreyFont
        doctorName.text = "Dr Faridha"
        doctorName.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(600))
        self.contentView.addSubview(doctorName)
        doctorName.translatesAutoresizingMaskIntoConstraints = false
        let doctorNameConsraints = [
            doctorName.topAnchor.constraint(equalTo: poliName.bottomAnchor, constant: 5),
            doctorName.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 15)
        ]
        constraints.append(contentsOf: doctorNameConsraints)
        
        queueAgainLbl.textColor = .HQueueDarkBlue
        queueAgainLbl.text = "Antri Lagi"
        queueAgainLbl.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(700))
        self.contentView.addSubview(queueAgainLbl)
        queueAgainLbl.translatesAutoresizingMaskIntoConstraints = false
        let queueAgainLblConstraints = [
            queueAgainLbl.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 15),
            queueAgainLbl.bottomAnchor.constraint(equalTo: backgroundBox.bottomAnchor, constant: -15)
        ]
        constraints.append(contentsOf: queueAgainLblConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
}
