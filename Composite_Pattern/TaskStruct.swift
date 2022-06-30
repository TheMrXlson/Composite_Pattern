//
//  TaskStruct.swift
//  Composite_Pattern
//
//  Created by Egor Efimenko on 30.06.2022.
//

import Foundation

protocol Task {
    var name: String { get }
    var countTasks: [Task] { get }
}

class TaskFolder: Task {
    
    var name: String
    var countTasks: [Task] = []
    
    init(name: String) {
        self.name = name
    }
    
}
