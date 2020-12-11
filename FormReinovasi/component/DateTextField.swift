//
//  DateTextField.swift
//  FormReinovasi
//
//  Created by Aprizal on 6/5/20.
//  Copyright © 2020 Aprizal. All rights reserved.
//

import UIKit

class DateTextField: UITextField {
    var didSelectedDate: ((_ dateString: String) -> Void)?
    private var privateDate: Date?
    var date: Date? {
        set {
            privateDate = newValue
            if !isFirstResponder {
                datePicker.setDate(newValue!, animated: false)
            }
        }
        get {
            return privateDate
        }
    }
    
    private lazy var dateFormatter = DateFormatter()
    
    @IBInspectable var dateFormat: String = "dd/MM/yyyy" {
        didSet {
            dateFormatter.dateFormat = dateFormat
        }
    }
    
    private lazy var datePicker = UIDatePicker()
    
    
    @IBInspectable var datePickerType: Bool = true {
        didSet {
            if datePickerType {
                datePickerMode = .date
            } else {
                datePickerMode = .time
            }
        }
    }
    var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            datePicker.datePickerMode = datePickerMode
           
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        datePicker.timeZone =  TimeZone.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = dateFormat
        if date != nil {
            datePicker.setDate(date!, animated: false)
        }
        datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
        datePicker.datePickerMode = datePickerMode
        datePicker.timeZone = .current
        inputView = datePicker
        
        //Write toolbar code for done button
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
//        datePicker.minimumDate = Date()
    }
    
    @objc private func didSelectDate(_ sender: UIDatePicker) {
        date = sender.date
        text = dateFormatter.string(from: sender.date)
    }
    
    //Toolbar done button function
    @objc func onClickDoneButton() {
        self.endEditing(true)
        self.didSelectedDate?(text ?? "")
    }
//    func asAge() -> Int {
//        guard let date = date else { return 0 }
//        let calendar = Calendar.current
//        let year = calendar.component(.year, from: date)
//        let month = calendar.component(.month, from: date)
//        let day = calendar.component(.day, from: date)
//
//        let dob = DateComponents(calendar: .current, year: year, month: month, day: day).date
//        return dob?.age ?? 0 // 49
//    }
}
