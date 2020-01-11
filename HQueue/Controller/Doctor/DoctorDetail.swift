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
    
    enum QueueRegisterState: String {
        case success = "success"
        case alreadyInQueue = "already in queue"
        case fail = "failure"
    }

    // MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        // Register network manager
        self.networkManager = NetworkManager()
        
        // Setup action register queue button
        self.daftarBtn.addTarget(self, action: #selector(registerQueueAction), for: .touchUpInside)
        
        // Init
        self.createSubviews()
        self.fetchInsurance()
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
    
    // MARK: - Register Queue
    @objc func registerQueueAction() {
        
        // data patient is empty
        if patientSelected == nil {
            presentAlert(
                alert: .init(
                    title: "Pasein belum dipilih",
                    message: "Dimohon untuk memilih pasien yang akan didaftarakan",
                    preferredStyle: .alert
                ),
                actions: nil,
                comletion: nil
            )
    
        // data schedule is empty
        } else if scheduleSelected == nil {
            presentAlert(
                alert: .init(
                    title: "Jadwal belum dipilih",
                    message: "Dimohon untuk memilih jadwal yang tersedia",
                    preferredStyle: .alert
                ),
                actions: nil,
                comletion: nil
            )
            
        } else {
            createQueue()
        }
    }
    
    // handle network register queue
    func createQueue() {
        var insuranceId: String? = nil
        if insuranceSelected?.id != "empty" { insuranceId = insuranceSelected?.id }
        networkManager.registerQueue(patienId: String(patientSelected!.id!), doctorScheduleId: scheduleSelected!.id, insuranceId: insuranceId) { (data, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.presentAlert(
                        alert: .init(
                            title: "Terjadi kesalahan",
                            message: error,
                            preferredStyle: .alert
                        ),
                        actions: nil,
                        comletion: nil
                    )
                }
            } else {
                if let data = data {
                    
                    if data.success {
                        DispatchQueue.main.async {
                             self.presentAlert(
                                 alert: .init(
                                     title: "Success",
                                     message: data.message,
                                     preferredStyle: .alert
                                 ),
                                 actions: [
                                    .init(title: "Ok", style: .default, handler: { action in
                                        let queueNav = self.navigationController as! QueueNavigationController
                                        queueNav.popToRootViewController {
                                            queueNav.queueNavigationDelegate?.didRegisterQueue()
                                        }
                                    })
                                ],
                                 comletion: nil
                             )
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.presentAlert(
                                alert: .init(
                                    title: "Information",
                                    message: data.message,
                                    preferredStyle: .alert
                                ),
                                actions: [
                                    .init(title: "Tutup", style: .default, handler: { action in
                                        let queueNav = self.navigationController as! QueueNavigationController
                                        queueNav.popToRootViewController {
                                            queueNav.queueNavigationDelegate?.didRegisterQueue()
                                        }
                                    })
                                ],
                                comletion: nil
                            )
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Wakeup Transition View
//    func wakeupTransitionView(for state: QueueRegisterState) {
//        self.transitionView.wekeupView(target: self, title: "Test", message: "Test Message", btnLabel: "Ok")
//    }
    
    // MARK: - Navigation
    @objc func pushToPatientList() {
        
        if self.isLogged() && self.ifIsVerifed() {
            let vc = PatientList()
            vc.perviousController = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = AccountController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Select Patient
extension DoctorDetail: PatientListPerviousControllerDelegate {
    func didPatientSelected(patient: Patient) {
        patientSelected = patient
        patientBtn.setTitle(patient.fullName, for: .normal)
        patientBtn.setTitleColor(.white, for: .normal)
        patientBtn.backgroundColor = .HQueueYellow
        
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
            if !currentDoctor.schedule[indexPath.row].isAvailable {
                cell.isUserInteractionEnabled = false
                cell.view.alpha = 0.6
            }
            cell.timeLbl.text = "\(currentDoctor.schedule[indexPath.row].timeStart) - \(currentDoctor.schedule[indexPath.row].timeEnd)"
            return cell
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: insuranceCellIdentifier, for: indexPath) as! InsuranceCell
        cell.defaultView.alpha = 0
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
    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if collectionView.tag == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellIdentifier, for: indexPath) as! DoctorScheduleCell
//        }
//    }
    
}


