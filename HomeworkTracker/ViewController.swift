//
//  ViewController.swift
//  HomeworkTracker
//
//  Created by Steven Chen on 11/21/21.
//

import SnapKit
import UIKit

protocol TaskInfoDelegate: AnyObject {
    func changeTaskName(newName: String)
    func changeTaskDueDate(newDueDate: String)
    func changeTaskSubject(newSubject: String)
}

private var selectedTaskTag: Int!

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    let reuseIdentifier = "taskCellReuse"
    let cellHeight: CGFloat = 90
    let cellSpacingHeight: CGFloat = 1
    
    let exampleTaskOne = Task(id: 1, task_name: "Example Task #1", subject: "Information Science", due_date: "Dec 17, 2021")
    let exampleTaskTwo = Task(id: 2, task_name: "Example Task #2", subject: "Physics", due_date: "Dec 14, 2021")
    let exampleTaskThree = Task(id: 3, task_name: "Example Task #3", subject: "Linear Algebra", due_date: "Dec 15, 2021")
    let exampleTaskFour = Task(id: 4, task_name: "Example Task #4", subject: "Chemistry", due_date: "Dec 12, 2021")
    
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        tasks = [exampleTaskOne, exampleTaskTwo, exampleTaskThree, exampleTaskFour]
        
        title = "My Tasks"
        view.backgroundColor = .white
        
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped)), animated: false)
        
        tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
        
        setupConstraints()
        getTasks()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func addTapped() {
        present(AddTaskViewController(), animated: true, completion: nil)
    }
    
    @objc func refresh() {
        getTasks()
    }
    
    func getTasks() {
        NetworkManager.getTasks { tasks in
            self.tasks = tasks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return self.tasks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TaskTableViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 5.0
        let task = tasks[indexPath.section]
//        print(task.task_name)
        cell.configure(for: task)
        return cell
    }
}

extension ViewController: TaskInfoDelegate {
    
    func changeTaskName(newName: String) {
        tasks[selectedTaskTag].task_name = newName
        tableView.reloadData()
    }
    
    func changeTaskDueDate(newDueDate: String) {
        tasks[selectedTaskTag].due_date = newDueDate
        tableView.reloadData()
    }
    
    func changeTaskSubject(newSubject: String) {
        tasks[selectedTaskTag].subject = newSubject
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        let selectedTask = tasks[indexPath.section]
        let EditTaskViewController = EditTaskViewController(selectedTaskID: selectedTask.id, placeHolderTaskNameText: selectedTask.task_name, placeHolderTaskDueDateText: selectedTask.due_date, placeHolderTaskSubjectText: selectedTask.subject)
        selectedTaskTag = indexPath.section
        EditTaskViewController.modalPresentationStyle = .overFullScreen
        EditTaskViewController.delegate = self
        present(EditTaskViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
//    tableviewdele

}

