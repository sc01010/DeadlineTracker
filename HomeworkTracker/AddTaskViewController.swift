//
//  AddTaskViewController.swift
//  HomeworkTracker
//
//  Created by Steven Chen on 12/3/21.
//

import SnapKit
import UIKit

class AddTaskViewController: UIViewController {
    
    let nameTextField = UITextField()
    let subjectTextField = UITextField()
    let dueDateTextField = UITextField()
    let addButton = UIButton()
    let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        let namePaddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        let dueDatePaddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        let subjectPaddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        
        let cancelButtonImage = UIImage(named: "cancelButton")
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setBackgroundImage(cancelButtonImage, for: UIControl.State.normal)
        closeButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.addSubview(closeButton)
        
        nameTextField.backgroundColor = .systemGray6
        nameTextField.layer.cornerRadius = 10
        nameTextField.placeholder = "Assignment Name"
        nameTextField.leftView = namePaddingView
        nameTextField.leftViewMode = .always
        view.addSubview(nameTextField)
        
        dueDateTextField.backgroundColor = .systemGray6
        dueDateTextField.layer.cornerRadius = 10
        dueDateTextField.placeholder = "Due Date"
        dueDateTextField.leftView = dueDatePaddingView
        dueDateTextField.leftViewMode = .always
        view.addSubview(dueDateTextField)
        
        subjectTextField.backgroundColor = .systemGray6
        subjectTextField.layer.cornerRadius = 10
        subjectTextField.placeholder = "Subject"
        subjectTextField.leftView = subjectPaddingView
        subjectTextField.leftViewMode = .always
        view.addSubview(subjectTextField)
        
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        dueDateTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        subjectTextField.snp.makeConstraints { make in
            make.top.equalTo(dueDateTextField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(subjectTextField.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(35)
        }
    }
    
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addTapped() {
        if let name = nameTextField.text, let dueDate = dueDateTextField.text, let subject = subjectTextField.text, name != "" && dueDate != "" && subject != "" {

            NetworkManager.addTask(task_name: name, due_date: dueDate, subject: subject) { task in
                print(task)
            }
            dismiss(animated: true, completion: nil)
        }
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
