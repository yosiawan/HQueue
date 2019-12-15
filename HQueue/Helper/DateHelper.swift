//
//  DateHelper.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

extension Date {
    
    func changeToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func changeFromString(dateString: String, format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let newDate = formatter.date(from: dateString) {
            return newDate
        }
        
        return Date()
    }
}
