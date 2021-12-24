//
//  Admin_StudentListViewController.swift
//  Assignment12
//
//  Created by DCS on 24/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Admin_StudentListViewController: UIViewController {
    
    private var StudentArray = [Student]()
    private let myTableView = UITableView()
    
    
    //var a=(UserDefaults.standard.string(forKey: "Name") ?? nil)!
    var a = "Sweta"
    private let SubTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "All students List"
        label.textColor = .brown
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.backgroundColor = .clear
        label.shadowColor = .black
        return label
    }()
    
    private let SearchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =
            NSAttributedString(string: "Enter Class of Student", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
    private let SearchButton : UIButton = {
        let button = UIButton()
        //button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(OnSearchClicked), for: .touchUpInside)
        let img = UIImage(named: "search.jpeg")
        button.setImage(img, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let LogoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(OnLogoutClicked), for: .touchUpInside)
        button.backgroundColor = UIColor(cgColor: UIColor.brown.cgColor)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StudentArray = CoreDataHandler.shared.fetch()
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg3")!)
        view.backgroundColor = .white
        view.addSubview(myTableView)
        setupTableView()
        view.addSubview(SubTitleLabel)
        view.addSubview(SearchTextField)
        view.addSubview(SearchButton)
        view.addSubview(LogoutButton)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SeeStudent))
        navigationItem.setRightBarButton(addItem, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        myTableView.frame = CGRect(x: 0, y: 160, width:view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom-100)
        SubTitleLabel.frame = CGRect(x: 10, y: 50, width: view.frame.size.width, height: 100)
        SearchTextField.frame = CGRect(x: 10, y: 120, width: 300, height: 40)
        SearchButton.frame = CGRect(x: 310, y: 120, width: 63, height: 40)
        LogoutButton.frame = CGRect(x: 70, y: 600, width: view.frame.size.width-150, height: 35)
    }
    
}

extension Admin_StudentListViewController :UITableViewDataSource,UITableViewDelegate {
    
    @objc func OnLogoutClicked()
    {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func OnSearchClicked()
    {
        if SearchTextField.text != ""
        {
            StudentArray = CoreDataHandler.shared.fetchStudentClassWise(classname1: SearchTextField.text ?? "")
        }
        else
        {
            StudentArray = CoreDataHandler.shared.fetch();
        }
        myTableView.reloadData()
        
    }
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
    }
    
    @objc func SeeStudent()
    {
        let newStudent = Admin_StudentDetailsViewController()
        navigationController?.pushViewController(newStudent, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let st = StudentArray[indexPath.row]
        cell.textLabel?.text = "\(st.spid) | \(st.name!) | \(st.sclass!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Admin_StudentDetailsViewController()
        vc.student = StudentArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let stud = StudentArray[indexPath.row]
        CoreDataHandler.shared.delete(s: stud){
            self.StudentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
