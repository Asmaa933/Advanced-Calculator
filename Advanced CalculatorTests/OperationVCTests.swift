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
        XCTAssertTrue(viewModel.getResult() == "Result = 5")
        viewModel.executeOperation(operation: "/", secondOperand: "0")
        XCTAssertTrue(viewModel.getResult() == "Result = 5")
        XCTAssertTrue(viewModel.errorMessage == "Can't divide on 0")
        viewModel.executeOperation(operation: "*", secondOperand: "aa")
        XCTAssertTrue(viewModel.getResult() == "Result = 5")
        XCTAssertTrue(viewModel.errorMessage == "Error in number")
        XCTAssertFalse(viewModel.getOperationArrCount() == 3)
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
        XCTAssertTrue(viewModel.getResult() == "Result = 45")
    }
    
    /**
     This function tests undo operation  function
     */
    func testUndoOperation(){
        viewModel.executeOperation(operation: "+", secondOperand: "5")
        viewModel.executeOperation(operation: "*", secondOperand: "3")
        viewModel.executeOperation(operation: "-", secondOperand: "7")
        viewModel.executeOperation(operation: "*", secondOperand: "2")
        viewModel.undoOperation(index: 0)
        XCTAssertTrue(viewModel.getOperationArrCount() == 3)
        XCTAssertTrue(viewModel.getResult() == "Result = 8")
        XCTAssertTrue(viewModel.getOperation(index: 0) == "- 7")
    }
    
}
