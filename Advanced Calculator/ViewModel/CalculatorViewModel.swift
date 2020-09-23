//
//  CalculatorViewModel.swift
//  Advanced Calculator
//
//  Created by Esma on 9/19/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import Foundation

class CalculatorViewModel{
    var updateUIClosure: (()->())?
    var showAlertClosure: (()->())?
    private var operationStore = OperationStore()
    private var result: Double?{
        didSet{
            updateUIClosure?()
        }
    }
    
    private(set) var errorMessage: String?{
        didSet{
            showAlertClosure?()
        }
    }
    
    func executeOperation(operation: String, secondOperand: String){
        guard let number = Double(secondOperand) else {
            errorMessage = "Error in number"
            return
        }
        
        if number == Double.infinity{
            errorMessage = "Second Operand is greater than maximum value"
            return
        }
        
        if operation == "/" && number == 0 {
            errorMessage = "Can't divide on 0"
            return
        }
        operationStore.addOperation(operation: "\(operation) \(number.stringWithoutZeroFraction)")
        calculate(operation: operation, number: number)
    }
    
    private func calculate(operation: String,number: Double){
        var tempResult = result ?? 0
        switch operation {
        case "+":
            tempResult += number
        case "-":
            tempResult -= number
        case "*":
            tempResult *= number
        case "/":
            tempResult /= number
        default:
            break
        }
        
        if tempResult < Double.infinity{
            result = tempResult
        }else{
            errorMessage = "Result is greater than maximum value"
        }
    }
    
    func redoOperation(){
        let operation = operationStore.getOperatorionsArray()[0]
        let splitTupple = splitOperationString(operation:operation)
        operationStore.addOperation(operation: operation)
        calculate(operation: splitTupple.0, number: splitTupple.1)
        
    }
    
    func undoOperation(index: Int){
        let splitTupple = splitOperationString(operation: operationStore.getOperatorionsArray()[index])
        operationStore.removeOperation(index: index)
        switch splitTupple.0 {
        case "+":
            calculate(operation: "-", number: splitTupple.1)
        case "-":
            calculate(operation: "+", number: splitTupple.1)
        case "*":
            calculate(operation: "/", number: splitTupple.1)
        case "/":
            calculate(operation: "*", number: splitTupple.1)
        default:
            break
        }
        
    }
    
    func resetCalculator(){
        operationStore.removeAllOperations()
        result = nil
        errorMessage = nil
    }
    
    func getResult() -> String{
        return "Result = \(result?.stringWithoutZeroFraction ?? "0")"
    }
    
    func getOperationArrCount() -> Int{
        return operationStore.getOperatorionsArray().count
    }
    
    func getOperation(index: Int) -> String {
        return operationStore.getOperatorionsArray()[index]
    }
    
    /**
     This function splits arithmetic operator from number
     ## Important Notes ##
     1. operation parameters be like  "+ 5".
     - parameters:
     - operation: String represent arithmetic operator and number
     - returns: Tuple has arithmetic operator and number values
     */
    private func splitOperationString(operation: String) -> (String,Double){
        let splittedArr = operation.split(separator: " ")
        let oper = String(splittedArr.first ?? "")
        let number = Double(splittedArr[1]) ?? 0
        return (oper,number)
    }
    
    
    
}
