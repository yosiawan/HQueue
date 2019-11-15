//
//  DoctorDetail.swift
//  HQueue
//
//  Created by Yosia on 11/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorDetail: UIViewController {

    var timeOptions = ["08.30"]
    var logoNames = ["admedika-logo", "mandiri-logo", "gardaOTO-logo"]
    
    let doctorImg = UIImageView()
    let doctorName = UILabel()
    let doctorGender = UILabel()
    
    let scheduleLbl = UILabel()
    var scheduleOptions: UICollectionView!
    
    let patientLbl: UILabel! = UILabel()
    let patientBtn: UIButton! = UIButton(frame: .zero)
    
    let insuranceLbl: UILabel! = UILabel()
    var insuranceOptions: UICollectionView!
    
    let daftarBtn = UIButton()

    // MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
    }
}

// MARK: - Flow Extension
extension DoctorDetail: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("duh -->", collectionView.tag)
        if collectionView.tag == 0 {
            return CGSize(width: 160, height: 130)
        }
        
        return CGSize(width: 72, height: 72)
    }

}

// MARK: - CollView Extension
extension DoctorDetail: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellIdentifier, for: indexPath) as! DoctorScheduleCell
            return cell
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: insuranceCellIdentifier, for: indexPath) as! InsuranceCell
        let image = UIImage(named: logoNames[indexPath.row])
        cell.insuranceImg.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellIdentifier, for: indexPath) as! DoctorScheduleCell
            if cell.isActive {
                cell.isActive = false
                cell.backgroundColor = .white
                cell.timeLbl.layer.borderColor = CGColor(srgbRed:0.98, green:0.97, blue:0.95, alpha:1.0)
            } else {
                cell.isActive = true
                cell.backgroundColor = .HQueueCream
                cell.timeLbl.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
                cell.timeLbl.backgroundColor = .HQueueYellow
            }
        }
//        _ = collectionView.dequeueReusableCell(withReuseIdentifier: insuranceCellIdentifier, for: indexPath) as! InsuranceCell
    }
}

