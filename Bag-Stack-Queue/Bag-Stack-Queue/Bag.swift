//
//  Bag.swift
//  Bag-Stack-Queue
//
//  Created by happy on 2020-07-11.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

public final class Bag<E> : Sequence {
    
    //First element of the bag
    private var first: Node<E>? = nil
    //Size of the bag
    private(set) var count: Int = 0
    
    init() {}
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public struct BagIterator<E> : IteratorProtocol {
        public typealias Element = E
        private var myCurrentItem: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.myCurrentItem = first
        }
        
        public mutating func next() -> E? {
            if let item = myCurrentItem?.item {
                myCurrentItem = myCurrentItem?.next
                return item
            }
            return nil
        }
    }
    
    public func isEmpty() -> Bool {
        return first == nil
    }
    //add an item
    public func add(item: E) {
        let oldItem = self.first
        self.first = Node<E>(item: item, next: oldItem)
        self.count += 1
    }
    
    public func makeIterator() -> some IteratorProtocol {
        return BagIterator<E>(first)
    }
    // Function  to print the whole bag
    public func printBag(){
        var item = self.first
        while item != nil{
            print(item?.item ?? "No value")
            item = item?.next
        }
    }
}


