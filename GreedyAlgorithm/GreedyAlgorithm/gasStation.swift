//
//  gasStation.swift
//  GreedyAlgorithm
//
//  Created by happy on 2020-07-29.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func canComplete(_ gas: [Int], _ cost: [Int]) -> Int {
    let count = gas.count
    let sum = gas.reduce(0, +)
    let totalCost = cost.reduce(0, +)
    if sum < totalCost {
        return -1
    }
    var total = [Int]()
    total.append(gas[0] - cost[0])
    var min = total[0]
    var minimumIndex = 0
    
    for i in 1..<count {
        total.append(total[i - 1] + (gas[i] - cost[i]))
        if total[i] < min {
            min = total[i]
            minimumIndex = i
        }
    }
    return (minimumIndex + 1) % count
}
