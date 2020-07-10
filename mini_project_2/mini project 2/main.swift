//
//  main.swift
//  mini project 2
//
//  Created by happy on 2020-07-08.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

var myBoard = Board.init(size: 8)
print("The solution with less than 115 iteration is:")
_ = solveQueens(board: &myBoard, col: 0)
print(myBoard)
var myBoardAllSolution = Board.init(size: 8)
print("All solution are: \n")
solveQueenAllSolution(board: &myBoardAllSolution, col: 0)

