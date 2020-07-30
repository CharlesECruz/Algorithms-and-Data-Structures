//
//  citySchedule.swift
//  GreedyAlgorithm
//
//  Created by happy on 2020-07-29.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func CityCost(_ costs: [[Int]]) -> Int {
    let count = costs.count / 2
    var cities = [CostMap]()
    for (index, cost) in costs.enumerated() {
        let difference = cost[0] - cost[1]
        cities.append(CostMap(abs(difference), index, difference < 0))
    }
    cities = cities.sorted().reversed()
    
    var costA = [Int]()
    var costB = [Int]()
    for i in 0..<costs.count {
        let currentCost = cities[i]
        if costA.count >= count {
            costB.append(currentCost.index)
        } else if costB.count >= count {
            costA.append(currentCost.index)
        } else {
            if currentCost.isA {
                costA.append(currentCost.index)
            } else {
                costB.append(currentCost.index)
            }
        }
    }
    
    var costAnswer = 0
    for i in 0..<costs.count / 2 {
        costAnswer += costs[costA[i]][0]
        costAnswer += costs[costB[i]][1]
    }

    return costAnswer
}

struct CostMap : Comparable {
    static func < (costA: CostMap, costB: CostMap) -> Bool {
        return costA.cost < costB.cost
    }
    
    let cost: Int
    let index: Int
    let isA: Bool
    
    init(_ cost: Int, _ index: Int, _ isA: Bool) {
        self.cost = cost
        self.index = index
        self.isA = isA
    }
}
