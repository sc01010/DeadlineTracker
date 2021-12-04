//
//  NetworkManager.swift
//  HomeworkTracker
//
//  Created by Steven Chen on 12/2/21.
//

import Alamofire
import Foundation

class NetworkManager {
    
    static let endpoint = "https://fa21hw.herokuapp.com/tasks/"
//    static let endpoint = "https://sc01010.github.io/Data/open_data.geojson"
    
    static func getTasks(completion: @escaping ([Task]) -> Void) {
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                print("getting all tasks")
                let jsonDecoder = JSONDecoder()
                if let taskResponse = try? jsonDecoder.decode(TasksResponse.self, from: data) {
                    let tasks = taskResponse.data
                    completion(tasks)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func addTask(task_name: String, due_date: String, subject: String, completion: @escaping (Task) -> Void) {
        let parameters: [String: String] = [
            "task_name": task_name,
            "due_date": due_date,
            "subject": subject
        ]
        
        AF.request("\(endpoint)", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let taskResponse = try? jsonDecoder.decode(TaskResponse.self, from: data) {
                    let task = taskResponse.data
                    completion(task)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func updateTask(task_id: Int, task_name: String, due_date: String, subject: String, completion: @escaping (TaskResponse) -> Void) {
        let parameters: [String: String] = [
            "task_name": task_name,
            "due_date": due_date,
            "subject": subject
        ]
        print(parameters)
        print(task_id)
        AF.request("\(endpoint)\(task_id)/", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let updateResponse = try? jsonDecoder.decode(TaskResponse.self, from: data) {
                    print(updateResponse)
                    let task = updateResponse
                    completion(task)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func deleteTask(task_id: Int, completion: @escaping (TaskResponse) -> Void) {
        print(task_id)
        
        AF.request("\(endpoint)\(task_id)/", method: .delete, encoding:JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let deleteResponse = try? jsonDecoder.decode(TaskResponse.self, from: data) {
                    print(deleteResponse)
                    let task = deleteResponse
                    completion(task)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
