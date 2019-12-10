//
//  DoctorListCell.swift
//  HQueue
//
//  Created by Yosia on 19/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorListCell: UITableViewCell {

    var doctorImg = UIImageView()
    var doctorName = UILabel()
    var jadwalTitle = UILabel()
    let queueCounterContainer = UIView()
    
    let labelJadwal1 = UILabel()
    let labelJadwal2 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        var constraints = [NSLayoutConstraint]()
        
        self.selectionStyle = .none
        
        // MARK: - Doctor Image
        doctorImg.layer.cornerRadius = 25
        doctorImg.layer.masksToBounds = true
        doctorImg.image = UIImage(named: "15ED3323-1B89-4A25-80B9-44D102558994")
        self.contentView.addSubview(doctorImg)
        doctorImg.translatesAutoresizingMaskIntoConstraints = false
        let doctorImgConstraints = [
            doctorImg.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doctorImg.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            doctorImg.heightAnchor.constraint(equalToConstant: 50),
            doctorImg.widthAnchor.constraint(equalToConstant: 50)
        ]
        constraints.append(contentsOf: doctorImgConstraints)
        
        // MARK: - Doctor Name
        doctorName.text = "Dr. Faridho Si. Al. An."
        doctorName.textColor = .black
        doctorName.font = UIFont.boldSystemFont(ofSize: 17)
        self.contentView.addSubview(doctorName)
        doctorName.translatesAutoresizingMaskIntoConstraints = false
        let doctorNameConstraints = [
            doctorName.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 10),
            doctorName.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 7),
            doctorName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10)
        ]
        constraints.append(contentsOf: doctorNameConstraints)
        
        // MARK: - Jadwal Title
        jadwalTitle.text = "Jadwal Praktek"
        jadwalTitle.textColor = .HQueueGreyFont
        jadwalTitle.font = UIFont(name: "", size: 13)
        self.contentView.addSubview(jadwalTitle)
        jadwalTitle.translatesAutoresizingMaskIntoConstraints = false
        let jadwalTitleConstraints = [
            jadwalTitle.topAnchor.constraint(equalTo: doctorName.bottomAnchor),
            jadwalTitle.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 10),
            jadwalTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10)
        ]
        constraints.append(contentsOf: jadwalTitleConstraints)
        
        // MARK: - Jadwal List
        self.contentView.addSubview(labelJadwal1)
        labelJadwal1.translatesAutoresizingMaskIntoConstraints = false
        let labelJadwal1Constraints = [
            labelJadwal1.topAnchor.constraint(equalTo: jadwalTitle.bottomAnchor),
            labelJadwal1.leadingAnchor.constraint(equalTo: doctorImg.trailingAnchor, constant: 10)
        ]
        constraints.append(contentsOf: labelJadwal1Constraints)
        
        self.contentView.addSubview(labelJadwal2)
        labelJadwal2.translatesAutoresizingMaskIntoConstraints = false
        let labelJadwal2Constraints = [
            labelJadwal2.topAnchor.constraint(equalTo: jadwalTitle.bottomAnchor),
            labelJadwal2.leadingAnchor.constraint(equalTo: labelJadwal1.trailingAnchor, constant: 10)
        ]
        constraints.append(contentsOf: labelJadwal2Constraints)
        
        
        // MARK: - Antrian Container
        queueCounterContainer.backgroundColor = .HQueueCream
        //self.contentView.addSubview(queueCounterContainer)
        queueCounterContainer.layer.cornerRadius = 10
        queueCounterContainer.layer.masksToBounds = true
        queueCounterContainer.translatesAutoresizingMaskIntoConstraints = false
        /*let queueCounterContainerConstraints = [
            queueCounterContainer.widthAnchor.constraint(equalToConstant: 80),
            queueCounterContainer.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            queueCounterContainer.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            queueCounterContainer.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor)
        ]*/
        //constraints.append(contentsOf: queueCounterContainerConstraints)
        
        // MARK: - Antrian Title
        let labelAntrian = UILabel()
        labelAntrian.text = "Antrian Saat Ini"
        labelAntrian.textColor = .HQueueGreyFont
        labelAntrian.numberOfLines = 2
        labelAntrian.font = labelAntrian.font.withSize(11)
        //self.contentView.addSubview(labelAntrian)
        labelAntrian.translatesAutoresizingMaskIntoConstraints = false
        /*let labelAntrianConstraints = [
            labelAntrian.topAnchor.constraint(equalTo: queueCounterContainer.topAnchor, constant: 5),
            labelAntrian.centerXAnchor.constraint(equalTo: queueCounterContainer.centerXAnchor),
            labelAntrian.widthAnchor.constraint(equalToConstant: 42)
        ]*/
        //constraints.append(contentsOf: labelAntrianConstraints)
        
        // MARK: - Antrian Amount
        let numOfAntrian = UILabel()
        numOfAntrian.text = "28"
        numOfAntrian.font = UIFont.boldSystemFont(ofSize: 22)
        numOfAntrian.textColor = .HQueueYellow
        //self.contentView.addSubview(numOfAntrian)
        numOfAntrian.translatesAutoresizingMaskIntoConstraints = false
        /*let numOfAntrianConstraints = [
            numOfAntrian.centerXAnchor.constraint(equalTo: queueCounterContainer.centerXAnchor),
            numOfAntrian.topAnchor.constraint(equalTo: labelAntrian.bottomAnchor)
        ]*/
        //constraints.append(contentsOf: numOfAntrianConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Etc

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
