//
//  main.swift
//  Bag-Stack-Queue
//
//  Created by happy on 2020-07-11.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation
print("Bag \n")
var myBag = Bag<Int>()
print(myBag.isEmpty())
myBag.add(item: 2)
myBag.add(item: 3)
myBag.add(item: 1)
print(myBag.isEmpty())
myBag.printBag()
print("\n\nStack\n")
var myStack = Stack<Int>()
print(myStack.isEmpty())
myStack.push(item: 3)
myStack.push(item: 4)
myStack.push(item: 2)
myStack.push(item: 5)
myStack.printStack()
print(myStack.pop() ?? "No value")
print(myStack.peek() ?? "No value")

print("\n\nQueue \n")

var myQueue = Queue<Int>(newQueue: [1,2,3,4])
myQueue.enqueue(value: 5)
print("peek: ",myQueue.peek() ?? "No value")
print("dequeue", myQueue.dequeue() ?? "No value")
print("dequeue", myQueue.dequeue() ?? "No value")
print("The whole queue is: ")
myQueue.printQueue()
