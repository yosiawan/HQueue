//
//  OnboardingViewController.swift
//  HQueue
//
//  Created by Yosia on 21/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    var counter         = 0
    var titles          = [
        "Halo, Selamat Datang di Antridoc",
        "Antridoc mempermudah anda dalam melakukan proses untuk berobat ke rumah",
        "Anda dapat melakukan registrasi dimana saja dan kapan saja tanpa harus antri dan datang ke rumah sakit"
    ]
    
    var images: [UIImage] = [
        #imageLiteral(resourceName: "pablo-welcome"),
        #imageLiteral(resourceName: "pablo-coffee-break"),
        #imageLiteral(resourceName: "done-5")
    ]
    
    var headerImg       = UIImageView()
    var whiteBox        = UIView()
    var pageControl     = UIPageControl()
    var titleLbl        = UILabel()
    var nextBtn         = UIButton()
    var skipBtn         = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setOnboardingConstraints()
        
        nextBtn.addTarget(self, action: #selector(self.btnClickAction(_ :)), for: .touchUpInside)
        skipBtn.addTarget(self, action: #selector(self.closeOnBoard), for: .touchUpInside)

    }
    
    @objc func btnClickAction(_ sender: UIButton) {
        if counter < titles.count - 1 {
            counter += 1
            pageControl.currentPage = counter
            titleLbl.text = titles[counter]
            headerImg.image = images[counter]
        }
        if counter >= titles.count - 1 {
            nextBtn.setTitle("Mulai", for: .normal)
            nextBtn.addTarget(self, action: #selector(self.closeOnBoard), for: .touchUpInside)
            skipBtn.alpha = 0
        }
    }
    
    @objc func closeOnBoard() {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        
        UIView.transition(with: keyWindow!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            let nav = QueueNavigationController(rootViewController: HomeQueueController())
            keyWindow!.rootViewController = nav
            UIView.setAnimationsEnabled(oldState)
        }, completion: nil)
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

//extension OnboardingViewController:
