//
//  DoctorDetail.swift
//  HQueue
//
//  Created by Yosia on 11/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class DoctorDetail: UIViewController {
    
    var networkManager: NetworkManager!
    var currentHospitalId: String!
    var currentDoctor: Doctor!
    
    var timeOptions = ["08.30"]
    var currentInsurances: [Asuransi] = []
    
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
    
    var insuranceSelected: Asuransi?
    var scheduleSelected: DoctorScedule?
    var patientSelected: Patient?

    // MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        createSubviews()
        fetchInsurance()
    }
    
    func setupView(_ doctor: Doctor) {
        doctorName.text = doctor.name
    }
    
    // MARK: - Fetch Data
    func fetchInsurance() {
        networkManager.getInsurance(hospital_id: currentHospitalId) { (insurances, error) in
            if error != "" {
                //print(#function, error)
            }
            
            if let insurances = insurances {
                self.currentInsurances = insurances
                self.currentInsurances.insert(Asuransi(name: "non asuransi", id: "empty"), at: 0)
                
                DispatchQueue.main.async {
                    self.insuranceOptions.reloadData()
                }
            }
        }
    }
}

// MARK: - Flow Extension
extension DoctorDetail: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: 160, height: 130)
        }
        
        return CGSize(width: 72, height: 72)
    }

}

// MARK: - CollView Extension
extension DoctorDetail: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return currentDoctor.schedule.count
        }else{
            return currentInsurances.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellIdentifier, for: indexPath) as! DoctorScheduleCell
            if indexPath.row == 0 {
                cell.isSelected = true
                self.scheduleSelected = currentDoctor.schedule[indexPath.row]
            }
            cell.timeLbl.text = currentDoctor.schedule[indexPath.row].time
            return cell
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: insuranceCellIdentifier, for: indexPath) as! InsuranceCell
        cell.defaultView.alpha = 0
        if currentInsurances[indexPath.row].id == "empty" {
            cell.defaultView.alpha = 1
            cell.isSelected = true
            self.insuranceSelected = currentInsurances[indexPath.row]
        }
//        if let insuranceImgUrl = currentInsurances[indexPath.row] {
//            cell.insuranceImg.downloaded(from: insuranceImgUrl, contentMode: .scaleAspectFill)
//        }
        
//        cell.insuranceImg.image = #imageLiteral(resourceName: "admedika-logo")
        cell.insuranceName.text = currentInsurances[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            self.scheduleSelected = currentDoctor.schedule[indexPath.row]
        }else{
            self.insuranceSelected = currentInsurances[indexPath.row]
        }
        
        print(self.scheduleSelected, self.insuranceSelected)
    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if collectionView.tag == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellIdentifier, for: indexPath) as! DoctorScheduleCell
//        }
//    }
    
    
}


