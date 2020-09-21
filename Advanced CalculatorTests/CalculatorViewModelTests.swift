//
//  CalculatorViewModelTests.swift
//  Advanced CalculatorTests
//
//  Created by Esma on 9/21/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import XCTest
@testable import Calculator

/// This is a class to test CalculatorViewModel functions
class CalculatorViewModelTests: XCTestCase {
    var operationStore: OperationStore!
    
    override func setUpWithError() throws {
        operationStore = OperationStore.shared
    }
    
    override func tearDownWithError() throws {
        operationStore = nil
    }
    
    /**
     This function putting dummy data in array
     */
    func fillArray(){
        operationStore.addOperation(operation: "+ 5")
        operationStore.addOperation(operation: "* 9")
        operationStore.addOperation(operation: "+ 30")
        operationStore.addOperation(operation: "+ 10")
    }
    
    /**
     This function tests splitting arithmetic operator from number
     */
    func testSplitOperation(){
        let operation = "+ 5"
        let splittedArr = operation.split(separator: " ")
        let oper = String(splittedArr.first ?? "")
        let number = Double(splittedArr[1]) ?? 0
        XCTAssertEqual(oper, "+")
        XCTAssertEqual(number, 5)
    }
    
    /**
     This function tests removing trailing zeros from double number
     */
    func testRemoveTrailingZeros(){
        var number = 1.00
        XCTAssertEqual(number.stringWithoutZeroFraction, "1")
        number = 1.012
        XCTAssertEqual(number.stringWithoutZeroFraction, "1.012")
    }
    
    /**
     This function tests getting array count
     */
    func testGetOperationArrCount(){
        fillArray()
        let count = operationStore.getOperatorionsArray().count
        XCTAssertEqual(count, 4)
    }
    
    /**
     This function tests getting operation from model
     */
    func testsGetOperationAtIndex(){
        let indexPath = IndexPath(row: 1, section: 0)
        fillArray()
        let operation = operationStore.getOperatorionsArray()[indexPath.row]
        XCTAssertEqual(operation, "+ 30")
    }
    
    /**
     This function tests executing operation with no error
     */
    func testExecuteOperationSuccess(){
        let operation = "+"
        let secondOperand = "5"
        var errorMessage = ""
        var result = 0.0
        guard let number = Double(secondOperand) else {
            errorMessage = "Error in number"
            return
        }
        
        if operation == "/" && number == 0 {
            errorMessage = "Can't divide on 0"
            return
        }
        operationStore.addOperation(operation: "\(operation) \(number.stringWithoutZeroFraction)")
        result = calculate(operation: operation, number: number)
        
        XCTAssertEqual(errorMessage, "")
        XCTAssertEqual(result, 5.0)
        XCTAssertEqual(operationStore.getOperatorionsArray()[0], "+ 5")
        
    }
    
    /**
     This function tests executing operation with  error
     */
    func testExecuteOperationFail(){
        let operation = "/"
        let secondOperand = "0"
        var errorMessage = ""
        var result = 0.0
        guard let number = Double(secondOperand) else {
            errorMessage = "Error in number"
            return
        }
        
        if operation == "/" && number == 0 {
            errorMessage = "Can't divide on 0"
            return
        }
        operationStore.addOperation(operation: "\(operation) \(number.stringWithoutZeroFraction)")
        result = calculate(operation: operation, number: number)
        
        XCTAssertEqual(errorMessage, "Can't divide on 0")
        XCTAssertEqual(result, 0.0)
        XCTAssertTrue(operationStore.getOperatorionsArray().isEmpty)
        
    }
    
    
    /**
     This function tests calculating result
     */
    func calculate(operation: String,number: Double) -> Double{
        var result = 0.0
        switch operation {
        case "+":
            result += number
        case "-":
            result -= number
        case "*":
            result *= number
        case "/":
            result /= number
        default:
            break
            
        }
        return result
    }
    
    /**
     This function tests redo the pervious operation
     */
    func testRedoOperation() {
        fillArray()
        let operation = operationStore.getOperatorionsArray()[0]
        let splitTupple = splitOperationString(operation:operation)
        operationStore.addOperation(operation: operation)
        let result =  calculate(operation: splitTupple.0, number: splitTupple.1)
        XCTAssertTrue(result == 95)
        XCTAssertTrue(operationStore.getOperatorionsArray().count == 5)
        XCTAssertEqual(operationStore.getOperatorionsArray()[0], operationStore.getOperatorionsArray()[1])
        
    }
    
    /**
     This function tests undo  operation at index
     */
    func testundoOperation(){
        fillArray()
        let index = 1
        var result = 0.0
        let splitTupple = splitOperationString(operation: operationStore.getOperatorionsArray()[index])
        operationStore.removeOperation(index: index)
        switch splitTupple.0 {
        case "+":
            result = calculate(operation: "-", number: splitTupple.1)
        case "-":
            result = calculate(operation: "+", number: splitTupple.1)
        case "*":
            result = calculate(operation: "/", number: splitTupple.1)
        case "/":
            result = calculate(operation: "*", number: splitTupple.1)
        default:
            break
        }
        
        XCTAssertTrue(result == 55)
        XCTAssertTrue(operationStore.getOperatorionsArray().count == 3)
    }
    
    
    /**
     This function  splitting arithmetic operator from number
     */
    func splitOperationString(operation: String) -> (String,Double){
        let splittedArr = operation.split(separator: " ")
        let oper = String(splittedArr.first ?? "")
        let number = Double(splittedArr[1]) ?? 0
        return (oper,number)
    }
    
    
}





