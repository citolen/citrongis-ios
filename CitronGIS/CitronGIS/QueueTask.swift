//
//  QueueTask.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 6/21/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

class QueueTask {
    private let taskCount:Int
    var taskArray:[(()->(), String)] = []
    var taskList:[String:() -> ()] = [:]
    var runningTask:[String:() -> ()] = [:]
    
    init(taskCount:Int)
    {
        self.taskCount = taskCount
    }
    func keepGoing()
    {
        if (taskArray.count > 0) {
            let toDo = taskArray.removeAtIndex(0)
            
            taskList.removeValueForKey(toDo.1)
            
            runningTask[toDo.1] = toDo.0
            toDo.0()
        }
    }
    func addTask(task:()->(), uuid:String)
    {
        
        if (runningTask.count < taskCount)
        {
            runningTask[uuid] = task
            task()
        }
        else
        {
            taskList[uuid] = task
            taskArray.append((task, uuid))
        }
    }
    func operationFinished(uuid:String)
    {
        self.runningTask.removeValueForKey(uuid)
        self.keepGoing()
    }
}