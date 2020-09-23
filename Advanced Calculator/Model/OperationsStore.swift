import Foundation

/// Class to contain the executed operations.
class OperationStore{
    
    // MARK: - Variables
    private var operationsArray = [String]()
    private var queue = DispatchQueue(label: "privateQueue")
    
    /// Adds executed operation to array
    /// - Parameter operation: String represent arithmetic operator and number
    /// - operation parameters be like  "+ 5"
    func addOperation(operation: String){
        queue.async {[weak self] in
            self?.operationsArray.insert(operation, at: 0)
        }
    }
    
    /// Removes operation at particular index.
    /// - Parameter index: Index of an operation in the array.
    func removeOperation(index: Int){
        queue.async {[weak self] in
            self?.operationsArray.remove(at: index)
        }
    }
    
    /// Removes all operations from array.
    func removeAllOperations(){
       queue.async {[weak self] in
            self?.operationsArray.removeAll()
        }
    }
    
    
    ///   Call it to get  the operations which executed.
    /// - Returns: Executed operations.
    func getOperatorionsArray() -> [String]{
        queue.sync {[weak self] in
            return self?.operationsArray ?? []
        }
    }
}

