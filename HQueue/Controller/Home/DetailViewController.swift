//
//  DetailViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 12/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

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
    
    var queueEntity: String! // nanti disesuaikan data yg ada
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkManager = NetworkManager()
        
        self.setupView()
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
    
    //MARK: Cancle Queue
    
    func cancleQueueProcess() {
        guard let currentQueue = self.queueEntity else { return }
        print("Cancel Queue Process")
    }
    
    
    //MARK: Handle Control
    
    //Lihat peta
    @IBAction func openDirectionMap(_ sender: Any) {
        
    }
    
    //Hubungi nomor telepon
    @IBAction func openPhoneCall(_ sender: Any) {
        
    }
    
    //Membatalkan antrian
    @IBAction func cancelQueueAction(_ sender: Any) {
        self.presetAlert(
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
