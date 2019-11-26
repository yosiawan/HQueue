//
//  HospitalDetail.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HospitalDetail: UIViewController {
    
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var poliButton: UIButton!
    @IBOutlet weak var asuransiCollection: UICollectionView!
    @IBOutlet weak var hospitalImage: UIImageView!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalAddress: UILabel!
    @IBOutlet weak var hospitalPhone: UILabel!
    
    var hospital: Hospital!
    
    func prepareForView() {
        hospitalName.text = hospital.name
        hospitalAddress.text = hospital.address
        hospitalPhone.text = hospital.phoneNumber
        if let imgUrlString = hospital.photo {
            hospitalImage.downloaded(from: "http://167.71.203.148/storage/hospitals/\(imgUrlString)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTransparantNav()
        viewWrapper.roundCorners(corners: [.topLeft], radius: 40)
        poliButton.layer.cornerRadius = poliButton.frame.height / 2
        
        prepareForView()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }

    @IBAction func listAsuransiAction(_ sender: Any) {
        let vc = AsuransiList()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func choosePoliAction(_ sender: Any) {
        let vc = PoliList()
        vc.title = "Poliklinik"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.hospital = self.hospital
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

//protocol HospitalDetailDelegate {
//    func didPushDetailHospital(detailView: HospitalDetail)
//}
