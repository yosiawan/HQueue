//
//  DetailViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 12/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailWrapper: UIView!
    @IBOutlet weak var sisaAntrianWrapper: UIView!
    @IBOutlet weak var estimasiGiliranWrapper: UIView!
    
    @IBOutlet weak var hospitalImg: UIImageView!
    @IBOutlet weak var hospitalNameLabel: UILabel!
    
    @IBOutlet weak var namePatentLabel: UILabel!
    
    @IBOutlet weak var nameDoctorLabel: UILabel!
    @IBOutlet weak var doctorImg: UIImageView!
    
    @IBOutlet weak var namePoliLabel: UILabel!
    
    @IBOutlet weak var insuranceLabel: UILabel!
    @IBOutlet weak var insuranceImg: UIImageView!
    
    @IBOutlet weak var sisaAntrianVal: UILabel!
    @IBOutlet weak var estimasiGiliranVal: UILabel!
    
    var networkManager: NetworkManager!
    
    var queueEntity: QueueEntity! {
        
        //print data queue
        didSet {
            
            if let hospitalImgUrl = self.queueEntity.hospital.photo {
                self.hospitalImg.downloaded(from: hospitalImgUrl, contentMode: .scaleAspectFill)
            }
            
            // TODO: - Menampilkan img doctor dan insurance
            /*
             if let insuranceImgUrl = self.queueEntity.insurance.img {
                 self.insuranceImg.downloaded(from: insuranceImgUrl, contentMode: UIView.ContentMode.scaleAspectFit)
             }
             */
            
             /*
             if let doctorImgUrl = self.queueEntity.insurance.img {
                 self.doctorImg.downloaded(from: doctorImgUrl, contentMode: UIView.ContentMode.scaleAspectFit)
                 self.doctorImg.layer.cornerRadius = doctorImg.frame.height / 2
             }
             */
            
            self.hospitalNameLabel.text = self.queueEntity.hospital.name
            self.namePatentLabel.text = self.queueEntity.patient.fullName
            self.nameDoctorLabel.text = self.queueEntity.doctor.name
            self.namePoliLabel.text = self.queueEntity.poliName
            self.insuranceLabel.text = self.queueEntity.insurance?.name != "" ? self.queueEntity.insurance?.name : "Non Ausransi"
            self.sisaAntrianVal.text = String(self.queueEntity.queueRemaining)
            // TODO: - menampilkan estimasi waktu
            /*
            self.estimasiGiliranVal.text = self.queueEntity.estimasiGiliran
             */
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        self.setupView()
        
        self.fetchCurrentQueue()
    }
    
    //MARK: Setup View
    fileprivate func setupView() {
        
        detailWrapper.roundCorners(corners: [.topLeft], radius: 40)
        sisaAntrianWrapper.layer.cornerRadius = 12
        estimasiGiliranWrapper.layer.cornerRadius = 12
        namePatentLabel.layer.cornerRadius = 12
        namePatentLabel.clipsToBounds = true
        doctorImg.layer.cornerRadius = doctorImg.frame.height / 2
    }
    
    //MARK: Fetch Current Queue
    
    func fetchCurrentQueue() {
        networkManager.getCurrentQueue { (data, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.presentAlert(
                        alert: .init(
                            title: "Info",
                            message: error,
                            preferredStyle: .alert
                        ),
                        actions: [
                            .init(title: "Reload", style: .default, handler: { (action) in
                                self.fetchCurrentQueue()
                            }),
                            .init(title: "Kembali", style: .cancel, handler: { (action) in
                                self.navigationController?.popToRootViewController(animated: true)
                            })
                            
                        ],
                        comletion: nil)
                }
            }
            
            if let queue = data?.data, data!.success {
                DispatchQueue.main.async {
                    self.queueEntity = queue
                    self.fetchQueueEstimationTime()
                }
            } else {
                DispatchQueue.main.async {
                    self.presentAlert(
                        alert: .init(
                            title: "Info",
                            message: data?.message,
                            preferredStyle: .alert
                        ),
                        actions: [
                            .init(title: "Kembali", style: .cancel, handler: { (action) in
                                self.navigationController?.popToRootViewController(animated: true)
                            })
                        ],
                        comletion: nil)
                }
            }
        }
    }
    
    func fetchQueueEstimationTime() {
        if let queueCurrent: QueueEntity = self.queueEntity {
            networkManager.getEstimation { (data, error) in
                if error != nil {
                    print(#function, error as Any)
                }
                
                if let estimation = data?.data {
                    DispatchQueue.main.async {
                        self.sisaAntrianVal.text = String( estimation.queueRemaining )
                        self.estimasiGiliranVal.text = estimation.getCurrentEstimate(openTimeSchedule: queueCurrent.doctorSchedule.timeStart)
                    }
                }
            }
        }
    }
    
    //MARK: Cancle Queue
    func cancleQueueProcess() {
        guard let currentQueue = self.queueEntity else { return }
        print("Cancel Queue Process", currentQueue)
    }
    
    
    //MARK: Handle Control
    
    //Lihat peta
    @IBAction func openDirectionMap(_ sender: Any) {
        guard let long = queueEntity.hospital.longitude, let lat = queueEntity.hospital.latitude else { return }
        self.setupForOpenMap(
            placeName: queueEntity.hospital.name,
            long: CLLocationDegrees(exactly: Float( long )!)!,
            lat: CLLocationDegrees(exactly: Float( lat )!)!
        )
    }
    
    //Hubungi nomor telepon
    @IBAction func openPhoneCall(_ sender: Any) {
        guard let phoneNumber = queueEntity.hospital.phoneNumber else { return }
        self.openPhoneCall(phoneNumber: phoneNumber)
    }
    
    //Membatalkan antrian
    @IBAction func cancelQueueAction(_ sender: Any) {
        self.presentAlert(
            alert: .init(
                title: "Konfirmasi",
                message: "Anda yakin ingin batalkan antrian?",
                preferredStyle: .alert
            ),
            actions: [
                .init(title: "Tidak", style: .cancel, handler: nil),
                .init(title: "Ya", style: .default, handler: { (UIAlertAction) in
                    self.cancleQueueProcess()
                })
            ],
            comletion: nil
        )
    }
    
}
