//
//  CalculatorViewModel.swift
//  Advanced Calculator
//
//  Created by Esma on 9/19/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import Foundation

/// View Model that updates the model from view inputs and updates views from model outputs.
class CalculatorViewModel{
    
    // MARK: - Variables
    var updateUIClosure: (()->())?
    var showAlertClosure: (()->())?
    private var operationStore = OperationStore()
    private var operationArr = [String]()
    private var result: Double?{
        didSet{
            operationArr = operationStore.getOperatorionsArray()
            updateUIClosure?()
        }
    }
    
    private(set) var errorMessage: String?{
        didSet{
            showAlertClosure?()
        }
    }
    
    /// Execute the selected
    /// - Parameters:
    ///   - operation: one of arithmatic operations =, - , * ,/
    ///   - secondOperand: the entered second operand
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
    
    
    /// Calculate the given operation and update result.
    /// - Parameters:
    ///   - operation: one of arithmatic operations =, - , * ,/
    ///   - secondOperand: the entered second operand as Double
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
    
    /// Redo the previous operation.
    func redoOperation(){
        let operation = operationArr[0]
        let splitTupple = splitOperationString(operation:operation)
        operationStore.addOperation(operation: operation)
        calculate(operation: splitTupple.0, number: splitTupple.1)
        
    }
    
    /// Undo the previous operation.
    func undoOperation(index: Int){
        let splitTupple = splitOperationString(operation: operationArr[index])
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
        
        // reset result if array is empty due to exponential values
        if operationArr.isEmpty && result != 0{
            result = 0
        }
                
    }
    
    /// Reset the calculator array and data.
    func resetCalculator(){
        operationStore.removeAllOperations()
        result = nil
        errorMessage = nil
    }
    
    /// Get calculation result.
    func getResult() -> String{
        return "Result = \(result ?? 0)"
    }
    
    /// Get operation array count.
    func getOperationArrCount() -> Int{
        return operationArr.count
    }
    
    /// Get operation from array at particular index.
    func getOperation(index: Int) -> String {
        return operationArr[index]
    }
    
    
    /// Splits arithmetic operator from number
    /// - Parameter operation: String represent arithmetic operator and number
    /// - Returns: Tuple has arithmetic operator and number values
    private func splitOperationString(operation: String) -> (String,Double){
        let splittedArr = operation.split(separator: " ")
        let oper = String(splittedArr.first ?? "")
        let number = Double(splittedArr[1]) ?? 0
        return (oper,number)
    }
    
}
