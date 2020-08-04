//
//  main.swift
//  MiniCostFlow
//
//  Created by happy on 2020-08-03.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

struct edge : Comparable {
    let value1: Int
    let value2: Int
    var cost: Int
    var activate: Bool
    
    init(_ input: [Int], _ activated: Bool) {
        self.value1 = input[0]
        self.value2 = input[1]
        self.cost = input[2]
        self.activate = activated
    }
    
    static func < (left: edge, right: edge) -> Bool {
        return left.cost < right.cost
    }
}

func merge<T : Comparable>(_ collection: [T], _ comparator: (T, T) -> Bool) -> [T] {
    if collection.count <= 1 {
        return collection
    }
    let middle = collection.count / 2
    var left = merge(Array(collection[..<middle]), comparator)
    var right = merge(Array(collection[middle...]), comparator)
    var sort: [T] = []
    while left.count != 0 && right.count != 0 {
        sort.append(comparator(left[0], right[0]) ? left.remove(at: 0) : right.remove(at: 0))
    }
    if left.count != 0 {
        sort.append(contentsOf: left)
    }
    if right.count != 0 {
        sort.append(contentsOf: right)
    }
    
    return sort
}

public struct UF {
    private var parent: [Int]
    private var size: [Int]
    private(set) var count: Int
    
    public init(_ n: Int) {
        self.count = n
        self.size = [Int](unsafeUninitializedCapacity: n) { (buffer, count) in
            for i in 0..<n {
                buffer[i] = 1
            }
            count = n
        }
        self.parent = [Int](unsafeUninitializedCapacity: n) { (buffer, count) in
            for i in 0..<n {
                buffer[i] = i
            }
            count = n
        }
    }
    
    public mutating func find(_ p: Int) -> Int {
        var root = p
        while root != parent[root] {
            parent[root] = parent[parent[root]]
            root = parent[root]
        }
        return root
    }
    
    public mutating func connected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    public mutating func union(_ p: Int, _ q: Int) {
        let i = find(p), j = find(q)
        if i == j {
            return
        } else if size[i] < size[j] {
            parent[i] = j
            size[j] += size[i]
        } else {
            parent[j] = i
            size[i] += size[j]
        }
    }
}



func minimumCostFlow() -> [Int] {
    print("The first line of input contains 3 integers, 𝑁, 𝑀 and D.\n( 1  ≤ 𝑁 ≤ 100,000, 𝑁 - 1 ≤ 𝑀 ≤ 200,000, 0 ≤ D ≤ 109)\nEach of the next 𝑀 lines contain three integers Ai, Bi, and Ci, which means that there is a pipe from building Aito building Bi that costs Ci per month when activated (1 <= Ai,Bi <= N,  1 <= Ci<= 109). The first N- 1of these lines represent the valid plan the city is currently using.\nIt is guaranteed that there is at most one pipe connecting any two buildings and no pipe connects a building to itself.\n")
    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let builds = firstLine[0]
    let pipes = firstLine[1]
    let pipesEnhancer = firstLine[2]
    
    var edges = [edge]()
    for i in 1...pipes {
        edges.append(edge(readLine()!.split(separator: " ").map { Int($0)! }, i < builds))
    }
    edges = edges.sorted()
    
    var unionFind = UF(builds + 1)
    var changedEdges = 0
    var actives = 0
    var lastCost = 0
    var insertedIndex = 0
    for myEdge in edges {
        if !unionFind.connected(myEdge.value1, myEdge.value2) {
            unionFind.union(myEdge.value1, myEdge.value2)
            actives += 1
            lastCost = myEdge.cost
            if !myEdge.activate {
                changedEdges += 1
            }
        }

        if actives >= builds - 1 { break }
        insertedIndex += 1
    }
    
    if lastCost < pipesEnhancer {
        if !edges[insertedIndex].activate {
            changedEdges -= 1
        }
    }
    var answer = [Int]()
    answer.append(changedEdges)
    return answer
}



while true {
    print(minimumCostFlow())
}
    
