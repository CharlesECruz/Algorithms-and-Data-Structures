//
//  main.swift
//  QuickSort
//
//  Created by happy on 2020-07-07.
//  Copyright © 2020 Carlos. All rights reserved.
//
import Foundation

var myArray = [100,2,5,9,6,6,8,18,2,1]
quickSort(myArray: &myArray, start: 0, end: (myArray.count - 1))
print("The sorted Array is")
for num in myArray{
    print(num, terminator:" ")
}
