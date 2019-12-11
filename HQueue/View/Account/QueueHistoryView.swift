//
//  QueueHistory.swift
//  HQueue
//
//  Created by Yosia on 11/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension QueueHistoryController {
    
    func setConstraints() {
        
        self.view.backgroundColor = .white
        
        var constraints = [NSLayoutConstraint]()
        
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        constraints.append(contentsOf: tableViewConstraints)
        
        titleLbl.text = "Riwayat Antrian"
        titleLbl.backgroundColor = .white
        titleLbl.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        self.view.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15)
        ]
        constraints.append(contentsOf: titleLblConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
}
