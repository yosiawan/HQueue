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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTransparantNav()
        viewWrapper.roundCorners(corners: [.topLeft], radius: 40)
        
        poliButton.layer.cornerRadius = poliButton.frame.height / 2
        // Do any additional setup after loading the view.
    }

    @IBAction func listAsuransiAction(_ sender: Any) {
        let vc = AsuransiList()
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
