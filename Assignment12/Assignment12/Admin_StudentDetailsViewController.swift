//
//  Admin_StudentDetailsViewController.swift
//  Assignment11
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Admin_StudentDetailsViewController: UIViewController {
    
    var student: Student?
    
    
    //let temp = SQLiteHandler.shared
    var ClassOfStudent:String?
    var MyStudentArray = [Student]()
    
    private let SubTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Student Details"
        label.textColor = .brown
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.backgroundColor = .clear
        label.shadowColor = .black
        return label
    }()
    //Name
    private let NameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    private let NameTextfield: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =
            NSAttributedString(string: "Enter Your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        textField.text = ""
        textField.textColor = .black
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        //textField.layer.cornerRadius = 15
        return textField
    }()
    
    //Gender
    private let GenderLabel : UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    private let GenderSegment : UISegmentedControl = {
        let sg = UISegmentedControl()
        sg.insertSegment(withTitle: "MALE", at: 1, animated: false)
        sg.insertSegment(withTitle: "FEMALE", at: 2, animated: false)
        sg.insertSegment(withTitle: "OTHER", at: 3, animated: false)
        sg.selectedSegmentIndex = 1
        sg.layer.borderColor = UIColor.black.cgColor
        sg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        sg.tintColor = .black
        return sg
    }()
    
    //Birthdate
    private let BirthDateLabel : UILabel = {
        let label = UILabel()
        label.text = "BirthDate"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    private let BirthDatePicker : UIDatePicker = {
        let db = UIDatePicker()
        db.timeZone = NSTimeZone.local
        db.datePickerMode = UIDatePicker.Mode.date
        db.layer.borderWidth = 1
        db.layer.borderColor = UIColor.black.cgColor
        db.tintColor = .black
        db.backgroundColor = .white
        db.setValue(UIColor.black, forKey: "textColor")
        let date = Date()
        db.setDate(date, animated: false)
        return db
    }()
    
    //Class
    private let ClassLabel : UILabel = {
        let label = UILabel()
        label.text = "Class"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    private let ClassPickerView : UIPickerView = {
        let pickerview = UIPickerView()
        pickerview.setValue(UIColor.black, forKeyPath: "textColor")
        pickerview.backgroundColor = .white
        pickerview.layer.borderWidth = 1
        pickerview.layer.borderColor = UIColor.black.cgColor
        pickerview.tintColor = .black
        return pickerview
    }()
    
    private let ClassArray = ["Computer Science","Biology","Micro-Biology","Environmental Science"]
    
    public let AddStudentButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add New Student", for: .normal)
        button.addTarget(self, action: #selector(OnAddStudentClicked), for: .touchUpInside)
        button.backgroundColor = UIColor(cgColor: UIColor.brown.cgColor)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "admin_bg")!)
        
        view.addSubview(SubTitleLabel)
        view.addSubview(NameLabel)
        view.addSubview(NameTextfield)
        
        view.addSubview(GenderLabel)
        view.addSubview(GenderSegment)
        
        view.addSubview(BirthDateLabel)
        view.addSubview(BirthDatePicker)
        
        view.addSubview(ClassLabel)
        view.addSubview(ClassPickerView)
        ClassPickerView.delegate = self
        ClassPickerView.dataSource = self
        view.addSubview(AddStudentButton)
        
        if let st = student
        {
            NameTextfield.text = st.name  // set name
            //set gender segment
            if st.gender == "MALE" {
                GenderSegment.selectedSegmentIndex = 0
            } else if st.gender == "FEMALE" {
                GenderSegment.selectedSegmentIndex = 1
            }else if st.gender == "OTHER" {
                GenderSegment.selectedSegmentIndex = 2
            }
            
            // set class pickerview
            for i in 0..<ClassArray.count
            {
                print("i=",i)
                print("Out Class Array =",ClassArray[i])
                print("st.Class = ",st.sclass as Any)
                if String(st.sclass!) == ClassArray[i]
                {
                    print("Class Array =",ClassArray[i])
                    ClassPickerView.selectRow(i,inComponent: 0,animated: false)
                }
            }
            
            //set birthdate
            BirthDatePicker.setDate(st.dob!, animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        SubTitleLabel.frame = CGRect(x: 10, y: 50, width: view.frame.size.width, height: 100)
        
        NameLabel.frame = CGRect(x: 10, y: 150, width: 100, height: 30)
        NameTextfield.frame = CGRect(x: 120, y: 150, width: 240, height: 30)
        
        GenderLabel.frame = CGRect(x: 10, y: 200, width: 100, height: 30)
        GenderSegment.frame = CGRect(x: 120, y: 200, width: 240, height: 30)
        
        BirthDateLabel.frame = CGRect(x: 10, y: 250, width: 100, height: 30)
        BirthDatePicker.frame = CGRect(x: 120, y: 250, width: 240, height: 40)
        
        ClassLabel.frame = CGRect(x: 10, y: 300, width: 100, height: 30)
        ClassPickerView.frame = CGRect(x: 120, y: 300, width: 240, height: 80)
        
        AddStudentButton.frame = CGRect(x: 80, y: 400, width: view.frame.size.width-150, height: 35)
    }
    
}

extension Admin_StudentDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ClassArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ClassArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ClassOfStudent = ClassArray[row]
    }
    
}

extension Admin_StudentDetailsViewController {
    
    //add button click
    @objc func OnAddStudentClicked()
    {
        
        if let st = student
        {
            let Name = NameTextfield.text!
            let Gender = GenderSegment.titleForSegment(at: GenderSegment.selectedSegmentIndex)!
            let Dob = BirthDatePicker.date
            let Class = ClassOfStudent!
            
            CoreDataHandler.shared.update(s: st, name: Name, gender: Gender, dob: Dob, sclass: Class) {
            print("Data Updated")
            }
        }
        else
        {
            MyStudentArray=CoreDataHandler.shared.fetchLastRecord()
            var Spid = 0
            
            if MyStudentArray == [Student]()
            {
                UserDefaults.standard.setValue(1000, forKey: "Spid")
                Spid = UserDefaults.standard.integer(forKey: "Spid")
            }
            else
            {
                Spid = UserDefaults.standard.integer(forKey: "Spid") + 1;
                UserDefaults.standard.setValue(Spid, forKey: "Spid")
                print("Sp ID = ",Spid)
            }
            
            print("Spid = ",Spid)
            let Name = NameTextfield.text!
            let Gender = GenderSegment.titleForSegment(at: GenderSegment.selectedSegmentIndex)!
            let Dob = BirthDatePicker.date
            let Class = ClassOfStudent!
            let Password = String(Spid)
            CoreDataHandler.shared.insert(spid: Spid, name: Name, gender: Gender, dob: Dob, sclass: Class, password: Password) {
                print("Data Inserted")
        }
            
    }
 }
}

