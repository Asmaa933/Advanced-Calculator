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
     This function tests addOperation function
     */
    func testAddOperation(){
        skip_addInArray(operation: "+ 5")
        skip_addInArray(operation: "* 9")
        
        XCTAssertNotNil(operationsArr)
        XCTAssertTrue(operationsArr.count == 2)
        XCTAssertEqual(operationsArr[0], "* 9")
    }
    
    /**
     This function tests remove operation function
     */
    func testRemoveOperation(){
        skip_addInArray(operation: "+ 5")
        skip_addInArray(operation: "* 9")
        skip_addInArray(operation: "+ 30")
        skip_addInArray(operation: "+ 10")
        skip_removeFromArr(index: 0)
        XCTAssertTrue(operationsArr.count == 3)
        XCTAssertEqual(operationsArr[0], "+ 30")
        skip_removeFromArr(index: 1)
        XCTAssertTrue(operationsArr.count == 2)
        XCTAssertEqual(operationsArr.first ?? "" , "+ 30")
        XCTAssertEqual(operationsArr.last ?? "", "+ 5")
    }
}
