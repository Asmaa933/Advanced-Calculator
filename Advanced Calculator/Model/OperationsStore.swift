//
//  OperationStore.swift
//  Advanced Calculator
//
//  Created by Esma on 9/19/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import Foundation

/// This is a class to contain the executed operations
class OperationStore{
    static var shared = OperationStore()
    private init() {}
    private var operationsArray = [String]()
    
    /**
     This function adds executed operation to array
     ## Important Notes ##
     1. operation parameters be like  "+ 5"
     - parameters:
     - operation: String represent arithmetic operator and number
     */
    func addOperation(operation: String){
        operationsArray.insert(operation, at: 0)
    }
    
    /**
     This function  removes executed  operation to array
     */
    func removeOperation(){
        operationsArray.removeFirst()
    }
    
    /**
     This function splits arithmetic operator from number
     ## Important Notes ##
     1. operation parameters be like  "+ 5".
     - parameters:
     - operation: String represent arithmetic operator and number
     - returns: Tuple has arithmetic operator and number values
     */
    func splitOperationString(operation: String) -> (String,Int){
       let splittedArr = operation.split(separator: " ")
        let oper = String(splittedArr.first ?? "")
        let number = Int(splittedArr[1]) ?? 0
        return (oper,number)
    }
    
    /**
     This function returns the operations which executed
     - returns: executed operations
     */
    func getOperatorionsArray() -> [String]{
        return operationsArray
    }
    
    
    
    
}
