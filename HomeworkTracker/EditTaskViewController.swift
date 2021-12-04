//
//  EditTaskViewController.swift
//  HomeworkTracker
//
//  Created by Steven Chen on 11/21/21.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    weak var delegate: TaskInfoDelegate?
    
    var titleLabel: UILabel!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var dueDateLabel: UILabel!
    var dueDateTextField: UITextField!
    var subjectLabel: UILabel!
    var subjectTextField: UITextField!
    var closeButton: UIButton!
    var saveButton: UIButton!
    
    var selectedTaskID: Int
    var placeHolderTaskNameText: String
    var placeHolderTaskDueDateText: String
    var placeHolderTaskSubjectText: String
    
    init(selectedTaskID: Int, placeHolderTaskNameText: String, placeHolderTaskDueDateText: String, placeHolderTaskSubjectText: String) {
        self.selectedTaskID = selectedTaskID
        self.placeHolderTaskNameText = placeHolderTaskNameText
        self.placeHolderTaskDueDateText = placeHolderTaskDueDateText
        self.placeHolderTaskSubjectText = placeHolderTaskSubjectText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        
        let cancelButtonImage = UIImage(named: "cancelButton")
        closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setBackgroundImage(cancelButtonImage, for: UIControl.State.normal)
        closeButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.addSubview(closeButton)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Edit Task"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30, weight: UIFont.Weight.heavy)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Task:"
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.text = placeHolderTaskNameText
        nameTextField.textAlignment = .left
        nameTextField.textColor = .black
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderColor = .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.cornerRadius = 8
        nameTextField.textAlignment = .left
        nameTextField.clearsOnBeginEditing = false
        view.addSubview(nameTextField)
        
        dueDateLabel = UILabel()
        dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        dueDateLabel.adjustsFontSizeToFitWidth = true
        dueDateLabel.text = "Due Date:"
        dueDateLabel.textAlignment = .left
        dueDateLabel.font = .systemFont(ofSize: 18)
        dueDateLabel.textColor = .black
        view.addSubview(dueDateLabel)
        
        dueDateTextField = UITextField()
        dueDateTextField.translatesAutoresizingMaskIntoConstraints = false
        dueDateTextField.adjustsFontSizeToFitWidth = true
        dueDateTextField.text = placeHolderTaskDueDateText
        dueDateTextField.textAlignment = .left
        dueDateTextField.textColor = .black
        dueDateTextField.borderStyle = .roundedRect
        dueDateTextField.layer.borderColor = .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        dueDateTextField.layer.borderWidth = 2
        dueDateTextField.layer.cornerRadius = 8
        dueDateTextField.clearsOnBeginEditing = false
        view.addSubview(dueDateTextField)
        
        subjectLabel = UILabel()
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.adjustsFontSizeToFitWidth = true
        subjectLabel.text = "Subject:"
        subjectLabel.textAlignment = .left
        subjectLabel.font = .systemFont(ofSize: 18)
        subjectLabel.textColor = .black
        view.addSubview(subjectLabel)
        
        subjectTextField = UITextField()
        subjectTextField.translatesAutoresizingMaskIntoConstraints = false
        subjectTextField.adjustsFontSizeToFitWidth = true
        subjectTextField.text = placeHolderTaskSubjectText
        subjectTextField.textAlignment = .left
        subjectTextField.textColor = .black
        subjectTextField.borderStyle = .roundedRect
        subjectTextField.layer.borderColor = .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        subjectTextField.layer.borderWidth = 2
        subjectTextField.layer.cornerRadius = 8
        subjectTextField.textAlignment = .left
        subjectTextField.backgroundColor = .white
        subjectTextField.clearsOnBeginEditing = false
        view.addSubview(subjectTextField)
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.borderColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        saveButton.layer.borderWidth = 2
        saveButton.layer.cornerRadius = 3
        saveButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(saveButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            dueDateLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            dueDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dueDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dueDateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            dueDateTextField.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor),
            dueDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dueDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dueDateTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: dueDateTextField.bottomAnchor, constant: 30),
            subjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            subjectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subjectLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            subjectTextField.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor),
            subjectTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            subjectTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subjectTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissViewController() {
        if let text = nameTextField.text, text != "" {
            delegate?.changeTaskName(newName: text)
        }
        if let text = dueDateTextField.text, text != "" {
            delegate?.changeTaskDueDate(newDueDate: text)
        }
        if let text = subjectTextField.text, text != "" {
            delegate?.changeTaskSubject(newSubject: text)
        }
        if let nameText = nameTextField.text, let dueDateText = dueDateTextField.text, let subjectText = subjectTextField.text, nameText != "" && dueDateText != "" && subjectText != "" {
            updateTask()
        }
//        dismiss(animated: true, completion: nil)
    }
    
    func updateTask() {
        NetworkManager.updateTask(task_id: selectedTaskID, task_name: nameTextField.text!, due_date: dueDateTextField.text!, subject: subjectTextField.text!) { task in
            self.dismiss(animated: true, completion: nil)
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
