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

// MARK: - CollView Extension
extension DoctorDetail: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // UNTUK BUAT LEBIH DARI 1 Collection view, assign tag ke masing2 col view dan detect pake if di extension
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: insuranceCellIdentifier, for: indexPath) as!
        InsuranceCell
        
        let image = UIImage(named: logoNames[indexPath.row])
        cell.insuranceImg.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: insuranceCellIdentifier, for: indexPath) as! InsuranceCell
    }
}

