//
//  DoctorDetailView.swift
//  HQueue
//
//  Created by Yosia on 13/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension DoctorDetail {
    func createSubviews() {
        self.view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal

        //  MARK: - Doctor Image
        doctorImg.layer.cornerRadius = 25
        doctorImg.image = UIImage(named: "doctor-default-img")
        self.view.addSubview(doctorImg)
        doctorImg.translatesAutoresizingMaskIntoConstraints = false
        doctorImg.heightAnchor.constraint(equalToConstant: CGFloat(114)).isActive = true
        doctorImg.widthAnchor.constraint(equalToConstant: CGFloat(114)).isActive = true
        doctorImg.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        doctorImg.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        //  MARK: - Doctor Name
        doctorName.font = UIFont.boldSystemFont(ofSize: 22)
        //doctorName.text = "Dr. Farida Putri Batubara S.AP, S.Si"
        doctorName.numberOfLines = 2
        self.view.addSubview(doctorName)
        doctorName.translatesAutoresizingMaskIntoConstraints = false
        doctorName.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 23).isActive = true
        doctorName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        doctorName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        //  MARK: - Doctor Gender
        doctorGender.text = "Wanita"
        doctorGender.textColor = .HQueueGreyFont
        self.view.addSubview(doctorGender)
        doctorGender.translatesAutoresizingMaskIntoConstraints = false
        doctorGender.topAnchor.constraint(equalTo: doctorName.bottomAnchor, constant: 3).isActive = true
        doctorGender.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 23).isActive = true
        
        // MARK: - Doctor Schedule
        scheduleLbl.text = "Pilih Jadwal Dokter"
        scheduleLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(scheduleLbl)
        scheduleLbl.translatesAutoresizingMaskIntoConstraints = false
        scheduleLbl.topAnchor.constraint(equalTo: doctorImg.bottomAnchor, constant: 22).isActive = true
        scheduleLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        // MARK: - Schedule Options
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        scheduleOptions = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scheduleOptions.backgroundColor = .white
        scheduleOptions.tag = 0
        self.view.addSubview(scheduleOptions)
        scheduleOptions.translatesAutoresizingMaskIntoConstraints = false
        scheduleOptions.heightAnchor.constraint(equalToConstant: 160).isActive = true
        scheduleOptions.topAnchor.constraint(equalTo: scheduleLbl.bottomAnchor, constant: 20).isActive = true
        scheduleOptions.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        scheduleOptions.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        scheduleOptions.register(UINib(nibName: "DoctorScheduleCell", bundle: nil), forCellWithReuseIdentifier: scheduleCellIdentifier)
        scheduleOptions.delegate = self
        scheduleOptions.dataSource = self
        scheduleOptions.showsHorizontalScrollIndicator = false
        //  MARK: - Patient Label
        patientLbl.text = "Pilih Data Pasien"
        patientLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(patientLbl)
        patientLbl.translatesAutoresizingMaskIntoConstraints = false
        patientLbl.topAnchor.constraint(equalTo: scheduleOptions.bottomAnchor, constant: 44).isActive = true
        patientLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        //  MARK: - Patient Button
        patientBtn.setTitle(" + Tambah Data Pasien", for: .normal)
        patientBtn.setTitleColor(.HQueueYellow, for: .normal)
        self.view.addSubview(patientBtn)
        patientBtn.translatesAutoresizingMaskIntoConstraints = false
        patientBtn.heightAnchor.constraint(equalToConstant: CGFloat(44)).isActive = true
        //patientBtn.widthAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        patientBtn.topAnchor.constraint(equalTo: patientLbl.bottomAnchor, constant: 20).isActive = true
        patientBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        patientBtn.layer.cornerRadius = 22
        patientBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        patientBtn.addTarget(self, action: #selector(pushToPatientList), for: .touchUpInside)

        //  MARK: - Insurance Label
        insuranceLbl.text = "Pilih Asuransi"
        insuranceLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(insuranceLbl)
        insuranceLbl.translatesAutoresizingMaskIntoConstraints = false
        insuranceLbl.topAnchor.constraint(equalTo: patientBtn.bottomAnchor, constant: 40).isActive = true
        insuranceLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true

        //  MARK: - Insurance Options
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        insuranceOptions = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        insuranceOptions.backgroundColor = .white
        insuranceOptions.tag = 1
        self.view.addSubview(insuranceOptions)
        insuranceOptions.translatesAutoresizingMaskIntoConstraints = false
        insuranceOptions.heightAnchor.constraint(equalToConstant: 72).isActive = true
        insuranceOptions.topAnchor.constraint(equalTo: insuranceLbl.bottomAnchor, constant: 20).isActive = true
        insuranceOptions.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        insuranceOptions.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        insuranceOptions.register(UINib(nibName: "InsuranceCell", bundle: nil), forCellWithReuseIdentifier: insuranceCellIdentifier)
        insuranceOptions.delegate = self
        insuranceOptions.dataSource = self
        insuranceOptions.showsHorizontalScrollIndicator = false
        
        //  MARK: - Daftar Button
        daftarBtn.setTitle("Daftar Antrian", for: .normal)
        daftarBtn.setTitleColor(.white, for: .normal)
        daftarBtn.layer.backgroundColor = .init(srgbRed: 0.12, green: 0.26, blue: 0.51, alpha: 1.0)
        daftarBtn.layer.cornerRadius = daftarBtn.frame.height / 2
        self.view.addSubview(daftarBtn)
        daftarBtn.translatesAutoresizingMaskIntoConstraints = false
        daftarBtn.heightAnchor.constraint(equalToConstant: CGFloat(51)).isActive = true
        daftarBtn.widthAnchor.constraint(equalToConstant: CGFloat(228)).isActive = true
        daftarBtn.topAnchor.constraint(equalTo: insuranceOptions.bottomAnchor, constant: 44).isActive = true
        daftarBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
}
