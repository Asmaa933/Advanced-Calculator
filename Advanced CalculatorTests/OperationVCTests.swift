//
//  OperationVCTests.swift
//  Advanced CalculatorTests
//
//  Created by Esma on 9/21/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import XCTest
@testable import Calculator

/// This is a class to test  calling viewModel functions
class OperationVCTests: XCTestCase {
    // MARK: - Variables
    var viewModel: CalculatorViewModel!
    
    override func setUpWithError() throws {
        viewModel = CalculatorViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        
    }
    
    /**
     This function tests execute opetation  function
     */
    func testExecuteOperation(){
        viewModel.executeOperation(operation: "+", secondOperand: "5")
        XCTAssertTrue(viewModel.getResult() == "Result = 5.0")
        //check errors
        viewModel.executeOperation(operation: "/", secondOperand: "0")
        XCTAssertTrue(viewModel.getResult() == "Result = 5.0")
        XCTAssertTrue(viewModel.errorMessage == "Can't divide on 0")
        XCTAssertFalse(viewModel.getOperationArrCount() == 2)
        XCTAssertTrue(viewModel.getOperationArrCount() == 1)
    }
    
    /**
     This function tests redo operation  function
     */
    func testRedoOperation(){
        viewModel.executeOperation(operation: "+", secondOperand: "5")
        viewModel.executeOperation(operation: "*", secondOperand: "3")
        viewModel.redoOperation()
        XCTAssertTrue(viewModel.getOperationArrCount() == 3)
        XCTAssertEqual(viewModel.getOperation(index: 0),viewModel.getOperation(index: 1))
        XCTAssertTrue(viewModel.getOperation(index: 0) == "* 3")
        XCTAssertTrue(viewModel.getResult() == "Result = 45.0")
    }
    
    /**
     This function tests undo operation  function
     */
    func testUndoOperation(){
        viewModel.executeOperation(operation: "+", secondOperand: "5")
        viewModel.executeOperation(operation: "*", secondOperand: "3")
        viewModel.executeOperation(operation: "-", secondOperand: "7")
        viewModel.executeOperation(operation: "/", secondOperand: "2")
        viewModel.undoOperation(index: 0)
        XCTAssertTrue(viewModel.getOperationArrCount() == 3)
        XCTAssertTrue(viewModel.getResult() == "Result = 8.0")
        XCTAssertTrue(viewModel.getOperation(index: 0) == "- 7")
        viewModel.undoOperation(index: 0)
        viewModel.undoOperation(index: 0)
        viewModel.undoOperation(index: 0)
        XCTAssertTrue(viewModel.getOperationArrCount() == 0)
    }
    
    /**
     This function tests reset calaculator  function
     */
    func testResetCalculator() {
        viewModel.resetCalculator()
        XCTAssertTrue(viewModel.getOperationArrCount() == 0)
        XCTAssertTrue(viewModel.getResult() == "Result = 0.0")
    }
}
