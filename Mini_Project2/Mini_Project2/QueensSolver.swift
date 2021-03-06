//
//  QueensSolver.swift
//  Mini_Project2
//
//  Created by happy on 2020-07-09.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

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
