//
//  schedule2.swift
//  DAG_TopologicalSort
//
//  Created by happy on 2020-07-29.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func findCourseSchedule() {
    print(chechSchedule2().searchOrder(2, [[1,0]]))
    print(chechSchedule2().searchOrder(4, [[1,0],[2,0],[3,1],[3,2]]))
}

class chechSchedule2 {
    func searchOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        let edges = prerequisites.count
        var order = [Int]()
        var checked = [Bool](repeating: false, count: numCourses)
        var both = [[Int]](repeating: [Int](), count: numCourses)
        var degree = [Int](repeating: 0, count: numCourses)
        
        
        for i in 0..<edges {
            let u = prerequisites[i][0], v = prerequisites[i][1]
            both[v].append(u)
            degree[u] += 1
        }
        
        let queue = myQueue2<Int>()
        for i in 0..<numCourses {
            if degree[i] == 0 {
                queue.enqueue(item: i)
            }
        }
        
        var visitedCount = 0
        while !queue.isEmpty() {
            let cur = queue.dequeue()!
            order.append(cur)
            if checked[cur] {
                return []
            }
            checked[cur] = true
            visitedCount += 1
            
            for adj in both[cur] {
                degree[adj] -= 1
                if degree[adj] == 0 {
                    queue.enqueue(item: adj)
                }
            }
        }
        return (visitedCount == numCourses) ? order : []
    }
}

public final class myQueue2<E> : Sequence {
    
    private var first: Node<E>? = nil
    private var last: Node<E>? = nil
    private(set) var count: Int = 0
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public init() {}
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func peek() -> E? {
        return last?.item ?? nil
    }
    
    public func enqueue(item: E) {
        let newNode = Node.init(item: item)
        if let last = last { last.next = newNode }
        last = newNode
        if isEmpty() { first = self.last }
        count += 1
    }
    
    public func dequeue() -> E? {
        guard let first = first else { return nil }
        self.first = first.next
        count -= 1
        return first.item
    }
    
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            current = first
        }
        
        public mutating func next() -> E? {
            if let current = current {
                self.current = current.next
                return current.item
            } else { return nil }
        }
        
        public typealias Element = E
    }
    
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension myQueue2: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}
