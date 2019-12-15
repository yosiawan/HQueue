//
//  QueueHistoryCell.swift
//  HQueue
//
//  Created by Yosia on 11/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class QueueHistoryCell: UITableViewCell {
    var backgroundBox = UIView()
    var hospitalName = UILabel()
    var poliName = UILabel()
    var doctorName = UILabel()
    var queueAgainLbl = UILabel()
    var dateLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
