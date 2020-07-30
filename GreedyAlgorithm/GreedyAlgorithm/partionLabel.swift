//
//  partionLabel.swift
//  GreedyAlgorithm
//
//  Created by happy on 2020-07-29.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

let lowerA = Character("a").asciiValue!

func partitionLabel(_ S: String) -> [Int] {
    var charPosition = [[Int]](repeating: [Int](repeating: -1, count: 2), count: 26)
    for (index, ch) in S.enumerated() {
        let chVal = Int(ch.asciiValue! - lowerA)
        if charPosition[chVal][0] == -1 {
           charPosition[chVal][0] = index
        }
        charPosition[chVal][1] = index
    }
    
    return partition(S, 0, charPosition)
}

fileprivate func partition(_ S: String, _ start: Int, _ pos: [[Int]]) -> [Int] {
    let length = S.count
    var answer = [Int]()
    
    var nextIndex = pos[Int(S.first!.asciiValue! - lowerA)][1] - start
    for (index, ch) in S.enumerated() {
        if index >= nextIndex { break }
        let currentPos = pos[Int(ch.asciiValue! - lowerA)][1] - start
        if nextIndex < currentPos {
            nextIndex = currentPos
        }
    }
    answer.append(nextIndex + 1)
    
    if answer[0] == length {
        return answer
    }

    nextIndex = pos[Int(S.last!.asciiValue! - lowerA)][0] - start
    for index in stride(from: length - 1, through: 0, by: -1) {
        if index <= nextIndex { break }
        let currentCharacter = S[S.index(S.startIndex, offsetBy: index)]
        let currentPos = pos[Int(currentCharacter.asciiValue! - lowerA)][0] - start
        if nextIndex > currentPos {
            nextIndex = currentPos
        }
    }
    let lastPos = length - nextIndex
    if answer[0] + lastPos != length {
        answer.append(contentsOf: partition(String(S.dropLast(lastPos).dropFirst(answer[0])), start + answer[0], pos))
    }
    
    answer.append(lastPos)
    return answer
}
