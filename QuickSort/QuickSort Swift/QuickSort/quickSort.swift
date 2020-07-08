//
//  quickSort.swift
//  QuickSort
//
//  Created by happy on 2020-07-07.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func partition( myArray:inout Array<Int> ,start:Int ,end:Int)-> Int{
    let pivot = myArray[end]
    var left = (start - 1)
    //var index = start
    for index in start..<end{
        if myArray[index] < pivot {
            left = left + 1
            myArray.swapAt(left, index)
        }
    }
    myArray.swapAt((left + 1), end)
    return (left + 1)
}

func quickSort(myArray:inout Array<Int> ,start:Int ,end:Int)-> Void{
    if(start <= end){
        let part = partition(myArray: &myArray, start: start, end: end)
        quickSort(myArray: &myArray, start: start, end: (end - 1))
        quickSort(myArray: &myArray, start: (part + 1), end: end)
    }
}
