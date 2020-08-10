//
//  main.swift
//  Problem_Set_8_(Shortest Path Algorithms)
//
//  Created by happy on 2020-08-08.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
    var myMatrix = [[Edge]](repeating: [], count: N + 1)
    var cost = [Int](repeating: Int.max, count: N + 1)
    var inspected = [Bool](repeating: false, count: N + 1)
    
    for currentPos in times {
        myMatrix[currentPos[0]].append(Edge(currentPos[1], currentPos[2]))
    }
    
    cost[K] = 0
    for _ in 0..<N - 1 {
        var minValue = Int.max
        var u = K
        for i in 1...N {
            if !inspected[i] && cost[i] < minValue {
                minValue = cost[i]
                u = i
            }
        }
        inspected[u] = true
        for union in myMatrix[u] {
            let v = union.destiny
            let curCost = cost[u] + union.cost
            if cost[v] > curCost {
                cost[v] = curCost
            }
        }
    }
    
    var maxDist = Int.min
    for i in 1...N {
        if maxDist < cost[i] {
            maxDist = cost[i]
        }
    }
    return (maxDist != Int.max) ? maxDist : -1
}



func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
    var myMatrix = [[Path]](repeating: [], count: n)
    var cost = [Int](repeating: Int.max, count: n)
    var inspected = [Bool](repeating: false, count: n)
    var myMaxDistance = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
    
    for myCurrentFlight in flights {
        myMatrix[myCurrentFlight[0]].append(Path(myCurrentFlight[1], myCurrentFlight[2]))
    }
    
    cost[src] = 0
    myMaxDistance[src][0] = 0
    for _ in 0..<n - 1 {
        var minValue = Int.max
        var u = src
        for i in 0..<n {
            if !inspected[i] && cost[i] < minValue {
                minValue = cost[i]
                u = i
            }
        }
        
        inspected[u] = true
        for i in 0...K {
            if myMaxDistance[u][i] != Int.max {
                for path in myMatrix[u] {
                    let v = path.to
                    let myCurrentCost = myMaxDistance[u][i] + path.cost
                    if i != K && myMaxDistance[v][i + 1] > myCurrentCost {
                        myMaxDistance[v][i + 1] = myCurrentCost
                    }
                    if cost[v] > myCurrentCost {
                        cost[v] = myCurrentCost
                    }
                }
            }
        }
    }
    
    return (cost[dst] != Int.max) ? cost[dst] : -1
}


struct Edge {
    let destiny: Int
    let cost: Int
    
    init(_ to: Int, _ cost: Int) {
        self.destiny = to
        self.cost = cost
    }
}

struct Path {
    let to: Int
    let cost: Int
    
    init(_ to: Int, _ cost: Int) {
        self.to = to
        self.cost = cost
    }
}



print(networkDelayTime([[2,1,1],[2,3,1],[3,4,1]], 4, 2))

print(findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0))

