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
    var operationsArr: [String]!
    
    override func setUpWithError() throws {
        
        operationsArr = [String]()
    }
    
    override func tearDownWithError() throws {
        operationsArr = nil
    }
    
    func skip_addInArray(operation: String){
        operationsArr.insert(operation, at: 0)
    }
    
    func skip_removeFromArr(index: Int)  {
        operationsArr.remove(at: index)
    }
    
    /**
     This function putting dummy data in array
     - returns: the total result for array
     */
    @discardableResult
    func skip_fillArray() -> Double{
        var totalResult = 0.0
        skip_addInArray(operation: "+ 5")
        skip_addInArray(operation: "* 9")
        skip_addInArray(operation: "+ 30")
        skip_addInArray(operation: "+ 10")
        
        for item in operationsArr.reversed(){
            let splittedItem = skip_splitOperationString(operation: item)
            totalResult = calculate(number1: totalResult, operation: splittedItem.0, number2: splittedItem.1)
        }
        return totalResult
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
        skip_fillArray()
        let count = operationsArr.count
        XCTAssertEqual(count, 4)
    }
    
    /**
     This function tests getting operation from model
     */
    func testsGetOperationAtIndex(){
        let index = 1
        skip_fillArray()
        let operation = operationsArr[index]
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
        skip_addInArray(operation: "\(operation) \(number.stringWithoutZeroFraction)")
        result = calculate(number1: result, operation: operation, number2: number)
        
        XCTAssertEqual(errorMessage, "")
        XCTAssertEqual(result, 5.0)
        XCTAssertEqual(operationsArr[0], "+ 5")
        
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
        skip_addInArray(operation: "\(operation) \(number.stringWithoutZeroFraction)")
        result = calculate(number1: result, operation: operation, number2: number)
        
        XCTAssertEqual(errorMessage, "Can't divide on 0")
        XCTAssertEqual(result, 0.0)
        XCTAssertTrue(operationsArr.isEmpty)
        
    }
    
    
    /**
     This function tests calculating result
     */
    func calculate(number1: Double,operation: String,number2: Double) -> Double{
        var result = 0.0
        switch operation {
        case "+":
            result = number1 + number2
        case "-":
            result = number1 - number2
        case "*":
            result = number1 * number2
        case "/":
            result = number1 / number2
        default:
            break
            
        }
        return result
    }
    
    /**
     This function tests redo the pervious operation
     */
    func testRedoOperation() {
        var result = skip_fillArray()
        let operation = operationsArr[0]
        let splitTupple = skip_splitOperationString(operation:operation)
        skip_addInArray(operation: operation)
        result =  calculate(number1: result, operation: splitTupple.0, number2: splitTupple.1)
        XCTAssertTrue(result == 95)
        XCTAssertTrue(operationsArr.count == 5)
        XCTAssertEqual(operationsArr[0], operationsArr[1])
        
    }
    
    /**
     This function tests undo  operation at index
     */
    func testundoOperation(){
        var result = skip_fillArray()
        let index = 1
        let splitTupple = skip_splitOperationString(operation: operationsArr[index])
        skip_removeFromArr(index: index)
        switch splitTupple.0 {
        case "+":
            result =  calculate(number1: result, operation: "-", number2: splitTupple.1)
        case "-":
            result =  calculate(number1: result, operation: "+", number2: splitTupple.1)
        case "*":
            result =  calculate(number1: result, operation: "/", number2: splitTupple.1)
        case "/":
            result =  calculate(number1: result, operation: "*", number2: splitTupple.1)
        default:
            break
        }
        
        XCTAssertTrue(result == 55)
        XCTAssertTrue(operationsArr.count == 3)
    }
    
    
    /**
     This function  splitting arithmetic operator from number
     */
    func skip_splitOperationString(operation: String) -> (String,Double){
        let splittedArr = operation.split(separator: " ")
        let oper = String(splittedArr.first ?? "")
        let number = Double(splittedArr[1]) ?? 0
        return (oper,number)
    }
    
    
}





