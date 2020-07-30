//
//  taskScheduler.swift
//  GreedyAlgorithm
//
//  Created by happy on 2020-07-29.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    let asciiA = Character("A").asciiValue!
    var chTasks = [Int](repeating: 0, count: 26)
    for character in tasks {
        chTasks[Int(character.asciiValue! - asciiA)] += 1
    }
    
    var task = [Task]()
    for (index, chTask) in chTasks.enumerated() {
        if chTask != 0 {
            task.append(Task(index, chTask))
        }
    }
    
    var intervals = 0
    while !task.isEmpty {
        var currentPos = -1
        var nextPos = -1
        for i in 0..<task.count {
            if nextPos == -1 || task[i].intervalTask < nextPos {
                nextPos = task[i].intervalTask
            }
            if task[i].isReady(intervals) {
                if currentPos == -1 || task[currentPos].numTasks < task[i].numTasks {
                    currentPos = i
                }
            }
        }
        
        if currentPos >= 0 {
            intervals += 1
            task[currentPos].doTask(intervals + n)
            if task[currentPos].taskDone() {
                task.remove(at: currentPos)
            }
        } else {
            intervals = nextPos
        }
    }

    return intervals
}

struct Task : Comparable {
    let letterID: Int
    var numTasks: Int
    var intervalTask = 0
    
    init(_ letter: Int, _ numTasks: Int) {
        self.letterID = letter
        self.numTasks = numTasks
    }
    
    static func < (valueA: Task, valueB: Task) -> Bool {
        return valueA.numTasks > valueB.numTasks
    }
    
    func isReady(_ intervals: Int) -> Bool {
        return intervalTask <= intervals
    }
    
    func taskDone() -> Bool {
        return numTasks == 0
    }
    
    mutating func doTask(_ interval: Int) {
        numTasks -= 1
        self.intervalTask = interval
    }
}
