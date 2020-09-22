//
//  OpeationsStoreTests.swift
//  Advanced CalculatorTests
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import XCTest
@testable import Calculator

class OpeationsStoreTests: XCTestCase {
    var operationsStore: OperationStore!
    
    override func setUpWithError() throws {
        operationsStore = OperationStore()
    }
    
    override func tearDownWithError() throws {
        operationsStore = nil
    }
    
    /**
     This function tests addOperation function
     */
    func testAddOperation(){
        operationsStore.addOperation(operation: "+ 5")
        operationsStore.addOperation(operation: "* 9")
        XCTAssertNotNil(operationsStore.getOperatorionsArray())
        XCTAssertTrue(operationsStore.getOperatorionsArray().count == 2)
        XCTAssertEqual(operationsStore.getOperatorionsArray()[0], "* 9")
    }
    
    /**
     This function tests remove operation function
     */
    func testRemoveOperation(){
        operationsStore.addOperation(operation: "+ 5")
        operationsStore.addOperation(operation: "* 9")
        operationsStore.addOperation(operation: "+ 30")
        operationsStore.addOperation(operation: "+ 10")
        operationsStore.removeOperation(index: 0)
        XCTAssertTrue(operationsStore.getOperatorionsArray().count == 3)
        XCTAssertEqual(operationsStore.getOperatorionsArray()[0], "+ 30")
        operationsStore.removeOperation(index: 1)
        XCTAssertTrue(operationsStore.getOperatorionsArray().count == 2)
        XCTAssertEqual(operationsStore.getOperatorionsArray().first ?? "" , "+ 30")
        XCTAssertEqual(operationsStore.getOperatorionsArray().last ?? "", "+ 5")
    }
    
    func testRemoveAllOperations(){
        operationsStore.addOperation(operation: "+ 5")
        operationsStore.addOperation(operation: "* 9")
        operationsStore.addOperation(operation: "+ 30")
        operationsStore.addOperation(operation: "+ 10")
        operationsStore.removeAllOperations()
        XCTAssertTrue(operationsStore.getOperatorionsArray().isEmpty)
    }
}
