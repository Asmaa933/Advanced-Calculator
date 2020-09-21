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
    var operationStore: OperationStore!
    
    override func setUpWithError() throws {
        operationStore = OperationStore.shared
    }
    
    override func tearDownWithError() throws {
        operationStore = nil
    }
    
    /**
     This function tests addOperation function
     */
    func testAddOperation(){
        operationStore.addOperation(operation: "+ 5")
        operationStore.addOperation(operation: "* 9")
        XCTAssertNotNil(operationStore.getOperatorionsArray)
        XCTAssertTrue(operationStore.getOperatorionsArray().count == 2)
        XCTAssertEqual(operationStore.getOperatorionsArray()[0], "* 9")
    }
    
    /**
    This function tests remove operation function
    */
    func testRemoveOperation(){
        operationStore.addOperation(operation: "+ 5")
        operationStore.addOperation(operation: "* 9")
        operationStore.addOperation(operation: "+ 30")
        operationStore.addOperation(operation: "+ 10")
        operationStore.removeOperation(index: 0)
        XCTAssertTrue(operationStore.getOperatorionsArray().count == 3)
        XCTAssertEqual(operationStore.getOperatorionsArray()[0], "+ 30")
        operationStore.removeOperation(index: 1)
        XCTAssertTrue(operationStore.getOperatorionsArray().count == 2)
        XCTAssertEqual(operationStore.getOperatorionsArray().first ?? "" , "+ 30")
        XCTAssertEqual(operationStore.getOperatorionsArray().last ?? "", "+ 5")
    }
}
