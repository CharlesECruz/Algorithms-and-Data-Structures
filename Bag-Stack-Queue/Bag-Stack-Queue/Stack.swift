//
//  Stack.swift
//  Bag-Stack-Queue
//
//  Created by happy on 2020-07-12.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

struct Stack<E>: Sequence {
    
    private var myStack = [E]()
    
    private(set) var count: Int = 0
    
    //returns true if stack is empty, otherwise false.
    public func isEmpty() -> Bool {
        return myStack.count == 0
    }

    
    //add an item
    mutating func push(item: E) {
        myStack.append(item)
        count += 1
    }
    
    //removes and returns the item most recently added to the stack
    mutating func pop() -> E? {
        return myStack.popLast()
    }
    
    //returns (but does not remove) the item most recently added to the stack.
    func peek() -> E? {
        return myStack.last
    }
    
    //StackIterator that iterates over the item in this stack in arbitrary order
    public struct StackIterator<E> : IteratorProtocol {
        public typealias Element = E
        private var myCurrentItem: E?

        fileprivate init(items: E?) {
            self.myCurrentItem = items
        }

        public mutating func next() -> E? {
            if let element = myCurrentItem.self {
                return element
            }
            return nil
        }
    }
    public func printStack(){
        for item in self.myStack{
            print(item)
        }
    }
    
    public func makeIterator() -> StackIterator<E> {
        return StackIterator(items: self as? E)
    }
    
}
