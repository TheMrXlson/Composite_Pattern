//
//  ViewController.swift
//  Composite_Pattern
//
//  Created by Egor Efimenko on 29.06.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleBar: UINavigationItem!
    
    var tasks = TaskFolder(name: "Главная")
    private var nextTasks: TaskFolder?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        titleBar.title = tasks.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "NextTask" else { return }
        guard let destination = segue.destination as? NextViewController else { return }
        destination.tasks = nextTasks
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alertPopup = UIAlertController(title: "Добавление задачи", message: "Введите текст", preferredStyle: .alert)
        
        alertPopup.addTextField { (textField: UITextField!) in
            textField.placeholder = "Введите текст"
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            if let textField = alertPopup.textFields?[0]{
                let temp = textField.text
                if temp != nil{
                    let task = TaskFolder(name: temp!)
                    self.tasks.countTasks.append(task)
                    self.tableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertPopup.addAction(addAction)
        alertPopup.addAction(cancelAction)
        present(alertPopup, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.countTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks.countTasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = "\(task.countTasks.count)"
        return cell
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks.countTasks[indexPath.row]
        nextTasks = task as? TaskFolder
        performSegue(withIdentifier: "NextTask", sender: nil)
        
    }
}
