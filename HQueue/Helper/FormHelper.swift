//
//  FormHelper.swift
//  HQueue
//
//  Created by Faridho Luedfi on 19/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

struct SelectValue {
    var key: String
    var value: String
}

class DropDownPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public var data: [SelectValue]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }

    public var textFieldBeingEdited: UITextField?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = data else { return 0 }
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = data else { return "" }
        return data[row].value
    }
    
    public var selectedValue: SelectValue? {
        get {
            if data != nil {
                return data![selectedRow(inComponent: 0)]
            } else {
                return nil
            }
        }
    }
}
