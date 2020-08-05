//
//  main.swift
//  MSTAlgorithm
//
//  Created by happy on 2020-08-03.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation
//
//  Created by Derrick Park on 2/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//
/// The UF struct represents a union-find (disjoint sets) data structure
/// It supports **union** and **find** operations, along with methods for
/// determining whether two nodes are in the same component and the total
/// number of components.
/// This implementation uses weighted quick union (by size or rank) with
/// full path compression.
/// Initializing a data structure with **n** nodes takes linear time.
/// Afterwards, **union**, **find**, and **connected** take logarithmic time
/// (in the worst case) and **count** takes constant time.
/// Moreover, the amortized time per **union**, **find**, and **connected** operation
/// has inverse Ackermann complexity (which is practically < 5 for 2^(2^(2^(2^16))) - undefined number).
public struct UF {
    /// parent[i] = parent of i
    private var parent: [Int]
    /// size[i] = number of nodes in tree rooted at i
    private var size: [Int]
    /// number of components
    private(set) var count: Int
    
    /// Initializes an empty union-find data structure with **n** elements
    /// **0** through **n-1**.
    /// Initially, each elements is in its own set.
    /// - Parameter n: the number of elements
    public init(_ n: Int) {
        self.count = n
        self.size = [Int](repeating: 1, count: n)
        self.parent = [Int](repeating: 0, count: n)
        for i in 0..<n {
            self.parent[i] = i
        }
    }
    
    /// Returns the canonical element(root) of the set containing element `p`.
    /// - Parameter p: an element
    /// - Returns: the canonical element of the set containing `p`
    public mutating func find(_ p: Int) -> Int {
        var canonicalElement = p
        repeat {
            canonicalElement = parent[canonicalElement]
        } while canonicalElement != parent[canonicalElement]
        parent[p] = canonicalElement
        return canonicalElement
    }
    
    /// Returns `true` if the two elements are in the same set.
    /// - Parameters:
    ///   - p: one elememt
    ///   - q: the other element
    /// - Returns: `true` if `p` and `q` are in the same set; `false` otherwise
    public mutating func connected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    /// Merges the set containing element `p` with the set containing
    /// element `q`
    /// - Parameters:
    ///   - p: one element
    ///   - q: the other element
    public mutating func union(_ p: Int, _ q: Int) {
        let rootP = find(p)
        let rootQ = find(q)
        let weightP = size[rootP]
        let weightQ = size[rootQ]
        if weightP > weightQ {
            parent[rootQ] = rootP
            size[rootP] = weightP + weightQ
        } else {
            parent[rootP] = rootQ
            size[rootQ] = weightP + weightQ
        }
    }
    
}



class TreeBinaryHeap<E: Comparable> {
    var data: [E]
    var size: Int
    
    init() {
        self.data = []
        self.size = 0
    }
    
    convenience init(_ collection:[E]) {
        self.init()
        for element in collection {
            push(element)
        }
    }
    
    func heapfyUp(_ index: Int) {
        let parent = (index - 1) / 2
        if index > 0, data[parent] >= data[index] {
            data.swapAt(parent, index)
            heapfyUp(parent)
        }
    }
    
    func heapfy(_ parent: Int) {
        let left = (parent * 2) + 1
        let right = (parent * 2) + 2
        if right < size {
            if data[left] < data[right] {
                if data[left] < data[parent] {
                    data.swapAt(left, parent)
                    heapfy(left)
                }
            } else {
                if data[right] < data[parent] {
                    data.swapAt(right, parent)
                    heapfy(right)
                }
            }
        } else if left < size, data[left] < data[parent] {
            data.swapAt(left, parent)
            heapfy(left)
        }
    }
    
    func push(_ element : E) {
        data.append(element)
        heapfyUp(size)
        size += 1
    }
    
    func pop() -> E? {
        if size > 0 {
            size -= 1
            data.swapAt(0, size)
            let result = data.remove(at: size)
            heapfy(0)
            return result
        }
        return nil
    }
    
    
}

fileprivate struct Tuple {
    let value1: Int
    let value2: Int
    let value3: Int
}

extension Tuple : Comparable {
    static func < (left: Tuple, right: Tuple) -> Bool {
        return left.value3 < right.value3
    }
}
/// Minimum Spanning Tree Algorithms
public final class MST {
  
  /// Prim's MST Algorithm O(ElgV)
  /// Use Priority Queue (Binary Heap) and Adjacency List
  /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple
  /// - Returns: the minimum cost spanning tree
  public func primMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
    var total = 0
    var graphChecked = [Bool](repeating: false, count: graph.count)
    graphChecked[0] = true
    var conexion = TreeBinaryHeap<Tuple>(graph[0].map {Tuple.init(value1: 0, value2: $0.v, value3: $0.w)})
    while let currentConexion = conexion.pop() {
        let value = currentConexion.value2
        let cost = currentConexion.value3
        if !graphChecked[value] {
            graphChecked[value] = true
            total += cost
            for myCurrentValue in graph[value].map({Tuple.init(value1: value, value2: $0.v, value3: $0.w)}) {
                if !graphChecked[myCurrentValue.value2] {
                    conexion.push(myCurrentValue)
                }
            }
        }
    }
    return total
  }
  
  /// Kruskal's MST Algorithm O(ElgE)
  /// Use Union-Find and Adjacency List (You can use Swift's built-in sort method.)
  /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple
  /// - Returns: the minimum cost spanning tree
  public func kruskalMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
    
    var conexions = [Tuple]()
    for value in 0..<graph.count {
        for currentIndex in graph[value] {
            conexions.append(Tuple(value1: value, value2: currentIndex.v, value3: currentIndex.w))
        }
    }
    conexions.sort()
    var myGraph = UF(graph.count)
    var sum = 0
    for myCurrentConection in conexions {
        let value1 = myCurrentConection.value1
        let value2 = myCurrentConection.value2
        let cost = myCurrentConection.value3
        if !myGraph.connected(value1, value2) {
            myGraph.union(value1, value2)
            sum += cost
        }
    }
    return sum
    
    
  }
}
