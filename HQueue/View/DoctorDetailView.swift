//
//  DoctorDetailView.swift
//  HQueue
//
//  Created by Yosia on 13/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        self.backgroundColor = .white
        let doctorImg = UIImageView()
        let doctorName = UILabel()
        let doctorGender = UILabel()
        let patientLbl: UILabel! = UILabel(frame: .zero)
        let patientBtn: UIButton! = UIButton(frame: .zero)
        
        doctorImg.layer.cornerRadius = 25
        doctorImg.image = UIImage(named: "foto_dr-farida")
        self.addSubview(doctorImg)
        doctorImg.translatesAutoresizingMaskIntoConstraints = false

        doctorName.font = UIFont.boldSystemFont(ofSize: 22)
        doctorName.text = "Dr. Farida Putri Batubara S.AP, S.Si"
        doctorName.numberOfLines = 2
        self.addSubview(doctorName)
        doctorName.translatesAutoresizingMaskIntoConstraints = false

        doctorGender.text = "Wanita"
        doctorGender.textColor = .HQueueGreyFont
        self.addSubview(doctorGender)
        doctorGender.translatesAutoresizingMaskIntoConstraints = false

        patientLbl.text = "Pilih Data Pasien"
        patientLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.addSubview(patientLbl)
        patientLbl.translatesAutoresizingMaskIntoConstraints = false
        
        patientBtn.setTitle(" + Tambah Data Pasien", for: .normal)
        patientBtn.setTitleColor(.HQueueYellow, for: .normal)
        self.addSubview(patientBtn)
        patientBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            doctorImg.heightAnchor.constraint(equalToConstant: CGFloat(114)),
            doctorImg.widthAnchor.constraint(equalToConstant: CGFloat(114)),
            doctorImg.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            doctorImg.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            
            doctorName.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 23),
            doctorName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            doctorName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            doctorGender.topAnchor.constraint(equalTo: doctorName.bottomAnchor, constant: 3),
            doctorGender.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 23),
            
            patientLbl.topAnchor.constraint(equalTo: doctorImg.bottomAnchor, constant: 44),
            patientLbl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            
            patientBtn.heightAnchor.constraint(equalToConstant: CGFloat(26)),
            patientBtn.widthAnchor.constraint(equalToConstant: CGFloat(200)),
            patientBtn.topAnchor.constraint(equalTo: patientLbl.bottomAnchor, constant: 20),
            patientBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}
