//
//  main.swift
//  TomatoFarm-ProblemSet3
//
//  Created by happy on 2020-07-25.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

struct myPoints {
    static let directions = [myPoints(-1, 0), myPoints(0, -1), myPoints(0, 1), myPoints(1, 0)]
    var x: Int, y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
print("First line: M N (M: width, N: height where 2 <= M, N <= 1000)\nNext N lines: 0s and 1s where 0(unripe tomatoes), 1(ripe tomatoes), -1(no tomatoes)")
let size = readLine()!.split(separator: " ")
let width = Int(size[0])!, farmHeight = Int(size[1])!

var numOfTomatoes = width * farmHeight
var ripes = 0
var farm = [[Int]]()
for _ in 0..<farmHeight {
    let cols = readLine()!.split(separator: " ")
    var row = [Int]()
    for col in cols {
        let colVal = Int(col)!
        row.append(colVal)
        if colVal == -1 {
            numOfTomatoes -= 1
        } else if colVal == 1 {
            ripes += 1
        }
    }
    farm.append(row)
}

var answer = [Int]()
var days = 0
while ripes < numOfTomatoes {
    let ripesBefore = ripes
    var nextFarm = farm
    for y in 0..<farmHeight {
        for x in 0..<width {
            if farm[y][x] == 0 {
                for dir in myPoints.directions {
                    let dr = y + dir.y, dc = x + dir.x
                    if dr >= 0 && dr < farmHeight && dc >= 0 && dc < width {
                        if farm[dr][dc] == 1 {
                            nextFarm[y][x] = 1
                            ripes += 1
                            break
                        }
                    }
                }
                if farm[y][x] == 1 {
                    break
                }
            }
        }
    }
    if ripesBefore == ripes {
        days = -1
        break
    }
    farm = nextFarm
    days += 1
}

print(days)
answer.append(days)




