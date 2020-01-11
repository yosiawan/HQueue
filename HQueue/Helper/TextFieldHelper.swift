//
//  TextFieldHelper.swift
//  HQueue
//
//  Created by Faridho Luedfi on 07/01/20.
//  Copyright © 2020 Apple Dev. Academy. All rights reserved.
//

import UIKit

extension UITextField {
    
    // MARK: Validator Field
    
}

extension String {
 
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
 
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
}
