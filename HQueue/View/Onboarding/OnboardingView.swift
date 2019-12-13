//
//  OnboardingView.swift
//  HQueue
//
//  Created by Yosia on 21/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension OnboardingViewController {
    
    func setOnboardingConstraints() {
        self.view.backgroundColor = .HQueueCream

        var constraints = [NSLayoutConstraint]()
        
        self.view.addSubview(headerImg)
        headerImg.image = UIImage(named: "pablo-augmented-reality")
        headerImg.translatesAutoresizingMaskIntoConstraints = false
        let headerImgConstraints = [
            headerImg.heightAnchor.constraint(equalToConstant: 274),
            headerImg.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerImg.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            headerImg.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ]
        constraints.append(contentsOf: headerImgConstraints)
        
        self.view.addSubview(whiteBox)
        whiteBox.layer.cornerRadius = 24
        whiteBox.layer.masksToBounds = false
        whiteBox.backgroundColor = .white
        whiteBox.translatesAutoresizingMaskIntoConstraints = false
        let whiteBoxConstraints = [
            whiteBox.topAnchor.constraint(equalTo: headerImg.bottomAnchor, constant: 90),
            whiteBox.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            whiteBox.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -14),
            whiteBox.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 14)
        ]
        constraints.append(contentsOf: whiteBoxConstraints)
        
        self.view.addSubview(pageControl)
        self.pageControl.numberOfPages = titles.count
        self.pageControl.currentPage = counter
//        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = .HQueueGreyFont
        self.pageControl.currentPageIndicatorTintColor = .red
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let paginationConstraints = [
            pageControl.topAnchor.constraint(equalTo: whiteBox.topAnchor, constant: 24),
            pageControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ]
        constraints.append(contentsOf: paginationConstraints)

        self.view.addSubview(titleLbl)
        titleLbl.text = titles[counter]
        titleLbl.numberOfLines = 3
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        let titleLblConstraints = [
            titleLbl.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 50),
            titleLbl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            titleLbl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ]
        constraints.append(contentsOf: titleLblConstraints)
        
        self.view.addSubview(nextBtn)
        nextBtn.setTitle("Selanjutnya", for: .normal)
        nextBtn.layer.cornerRadius = 22
        nextBtn.layer.masksToBounds = true
        nextBtn.backgroundColor = .HQueueDarkBlue
        nextBtn.titleLabel?.textColor = .white
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        let nextBtnConstraints = [
            nextBtn.widthAnchor.constraint(equalToConstant: 170),
            nextBtn.heightAnchor.constraint(equalToConstant: 44),
            nextBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 150),
            nextBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ]
        constraints.append(contentsOf: nextBtnConstraints)
        
        self.view.addSubview(skipBtn)
        skipBtn.setTitle("Lewati", for: .normal)
        skipBtn.setTitleColor(.red, for: .normal)
        skipBtn.translatesAutoresizingMaskIntoConstraints = false
        let skipBtnConstraints = [
            skipBtn.widthAnchor.constraint(equalToConstant: 170),
            skipBtn.heightAnchor.constraint(equalToConstant: 44),
            skipBtn.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 10),
            skipBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ]
        constraints.append(contentsOf: skipBtnConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
}
