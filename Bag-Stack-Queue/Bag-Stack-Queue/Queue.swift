//
//  Queue.swift
//  Bag-Stack-Queue
//
//  Created by happy on 2020-07-12.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

class Queue<E> {
    private var myQueue: [E] = []
    private(set) var count = 0
    //create an empty queue (initializer)
    init(newQueue: [E]){
        self.myQueue = newQueue
        count = newQueue.count
    }
    //add an item
    func enqueue(value: E) {
        myQueue.append(value)
        count += 1
    }
    //removes and returns the item least recently added to the queue
    func dequeue() -> E? {
        count -= 1
        return myQueue.isEmpty ? nil : myQueue.removeFirst()
    }
    //returns (but does not remove) the item least recently added to the queue.
    func peek() -> E? {
        return myQueue.first
    }
    func isEmpty()-> Bool{
        return myQueue.count == 0
    }
    public func printQueue(){
        for item in self.myQueue{
            print(item)
        }
    }
}
