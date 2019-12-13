//
//  DoctorListView.swift
//  HQueue
//
//  Created by Yosia on 19/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension DoctorList {
    
    func setupConstraints() {
        self.view.backgroundColor = .white
        
        var constraints = [NSLayoutConstraint]()

        // MARK: - Nama Poli
        self.view.addSubview(namaPoli)
        //namaPoli.text = "Spesialis Anak"
        namaPoli.font = UIFont.boldSystemFont(ofSize: 13)
        namaPoli.translatesAutoresizingMaskIntoConstraints = false
        let namaPoliConstraints = [
            namaPoli.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            namaPoli.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ]
        constraints.append(contentsOf: namaPoliConstraints)
        
        // MARK: - Description
        self.view.addSubview(descriptionLbl)
        descriptionLbl.text = "Dokter Praktik Hari ini"
        descriptionLbl.font = UIFont.boldSystemFont(ofSize: 22)
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        let descriptionLblConstraints = [
            descriptionLbl.topAnchor.constraint(equalTo: namaPoli.bottomAnchor, constant: 10),
            descriptionLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ]
        constraints.append(contentsOf: descriptionLblConstraints)
        
        // MARK: - Doctor List Table
        self.view.addSubview(doctorListTable)
        doctorListTable.translatesAutoresizingMaskIntoConstraints = false
        let doctorListTableConstraints = [
            doctorListTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            doctorListTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            doctorListTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            doctorListTable.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 20)
        ]
        constraints.append(contentsOf: doctorListTableConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
}
