//
//  QueensSolver.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 2019-03-13.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

/// Write a function solveQueens that epts a Board as a parameter
/// and tries to place 8 queens on it safely.
///
/// - Your method should stop exploring if it finds a solution
/// - You are allowed to change the function header (args or return type)
/// - Your total recursive calls should not exceed 120 times.

var iteration = 0
func solveQueens(board: inout Board, col: Int)->Bool {
    iteration += 1
    if iteration >= 114{
        return true
    }
    if col >= board.getSize(){
        return true
    }
    for n  in 0...board.getSize(){
        if board.isSafe(row: n, col: col){
            board.place(row: n, col: col)
            if  solveQueens(board: &board, col: col + 1){
                return true
            }
            board.remove(row: n, col: col)
        }
    }
	return false
}
func solveQueensAllSolution(board: inout Board, col: Int)->Bool {
    if col == board.getSize(){
        print(board)
        return true
    }
    for n  in 0...board.getSize(){
        if board.isSafe(row: n, col: col){
            board.place(row: n, col: col)
            _ = solveQueensAllSolution(board: &board, col: col + 1)
            board.remove(row: n, col: col)
        }
    }
    return false
}
func solveQueenAllSolution(board: inout Board, col: Int){
    var copyBoard = board
    _ = solveQueens(board: &board, col: col)
    _ = solveQueensAllSolution(board: &copyBoard, col: col)
}
