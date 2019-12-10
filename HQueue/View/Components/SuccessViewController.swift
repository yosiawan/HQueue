//
//  SuccessViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 10/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func setUpSuccessView(title: String, message: String?, btnLabel: String? ) {
        self.subjectTitle.text = title
        
        if let message = message {
            self.messageLabel.text = message
        }
        
        if let btnLabel = btnLabel {
            self.finishButton.setTitle(btnLabel, for: .normal)
        }
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
