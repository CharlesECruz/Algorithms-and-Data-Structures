//
//  main.swift
//  Assigment1
//
//  Created by happy on 2020-06-24.
//  Copyright © 2020 Carlos. All rights reserved.
//

import Foundation

func evaluate(expr:String ,ini:Int ,end:Int) -> Int {
    let exprArray:[Character] = Array(expr)
    if ini == end {
        return Int(String(exprArray[ini]))!
    }else{
        let auxIni = ini + 1,AuxEnd = end - 1
        var auxInitial = auxIni
        var parenthesesOpen = true
        while parenthesesOpen == false || (exprArray[auxInitial] != "+" && exprArray[auxInitial] != "-" && exprArray[auxInitial] != "*"){
            if exprArray[auxInitial] == "(" || exprArray[auxInitial] == ")"{
                parenthesesOpen = !parenthesesOpen
            }
            auxInitial = auxInitial + 1
        }
        let operation = exprArray[auxInitial]
        if operation == "+" {
            return evaluate(expr: expr, ini: auxIni, end: (auxInitial - 1)) + evaluate(expr: expr, ini: (auxInitial + 1), end: AuxEnd)
        }else if operation == "-"{
            return evaluate(expr: expr, ini: auxIni, end: (auxInitial - 1)) - evaluate(expr: expr, ini: (auxInitial + 1), end: AuxEnd)
        }else{
            return evaluate(expr: expr, ini: auxIni, end: (auxInitial - 1)) * evaluate(expr: expr, ini: (auxInitial + 1), end: AuxEnd)
        }
    }
}
print("Put the expression to evaluet:")
var expresion:String = readLine()!
print("I receibe",expresion," and the answer is:")
print(evaluate(expr: expresion , ini: 0, end: expresion.count-1))
