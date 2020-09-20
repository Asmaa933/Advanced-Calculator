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
    private var operationStore = OperationStore.shared
    private var result = 0{
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
        switch operation {
        case "+":
            break
        case "-":
            break
        case "*":
            break
        case "/":
            break
        default:
            print("default")
        }
    }
    
    func redoOperation(){
        
    }
    
    func undoOperation(){
        
    }
    
    func getResult() -> String{
        return "Result = \(result)"
    }
    
    func getOperationArrCount() -> Int{
        return operationStore.getOperatorionsArray().count
    }
    
    func getOperation(atIndex: IndexPath) -> String {
        return operationStore.getOperatorionsArray()[atIndex.row]
    }
    
    
    
    
}
