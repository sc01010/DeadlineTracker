//
//  TaskTableViewCell.swift
//  HomeworkTracker
//
//  Created by Steven Chen on 11/21/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var dueDateLabel: UILabel!
    var SubjectLabel: UILabel!
    
    var closeButton: UIButton!
    var selectedTaskID: Int!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = .white
        
        let cancelButtonImage = UIImage(named: "cancelButton")
        closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setBackgroundImage(cancelButtonImage, for: UIControl.State.normal)
        closeButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        contentView.addSubview(closeButton)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "placeholder"
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 14, weight: UIFont.Weight.heavy)
        contentView.addSubview(nameLabel)
        
        dueDateLabel = UILabel()
        dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        dueDateLabel.text = "placeholder"
        dueDateLabel.adjustsFontSizeToFitWidth = true
        dueDateLabel.textColor = .black
        dueDateLabel.font = .systemFont(ofSize: 10)
        contentView.addSubview(dueDateLabel)
        
        SubjectLabel = UILabel()
        SubjectLabel.translatesAutoresizingMaskIntoConstraints = false
        SubjectLabel.text = "placeholder"
        SubjectLabel.adjustsFontSizeToFitWidth = true
        SubjectLabel.textColor = .black
        SubjectLabel.font = .systemFont(ofSize: 10)
        contentView.addSubview(SubjectLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            dueDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            dueDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dueDateLabel.heightAnchor.constraint(equalToConstant: 20),
            dueDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dueDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            SubjectLabel.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor, constant: 5),
            SubjectLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            SubjectLabel.heightAnchor.constraint(equalToConstant: 20),
            SubjectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            SubjectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
    }
    
    @objc func cancelButtonPressed() {
        print("deleted task")
        deleteTask()
    }
    
    func configure(for task: Task) {
        nameLabel.text = task.task_name
        dueDateLabel.text = "Due Date: \(task.due_date)"
        SubjectLabel.text = "Subject: \(task.subject)"
        selectedTaskID = task.id
    }
    
    func deleteTask() {
        NetworkManager.deleteTask(task_id: selectedTaskID) { task in
            print("deletion successful")
        }
    }
    
}
