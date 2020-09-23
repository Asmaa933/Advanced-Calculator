//
//  CalculatorVC.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

/// Class  responsible for represent data in calculator view and deal with interaction from view.
class CalculatorVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var operationView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var operandTextField: UITextField!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var undoButton: UIButton!
    @IBOutlet private weak var redoButton: UIButton!
    @IBOutlet private weak var toastLabel: UILabel!
    
    // MARK: - Variables
    private var selectedButton: UIButton?{
        didSet{
            oldValue?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectedButton?.backgroundColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
        }
    }
    private lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel()
    }()
    
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
    }
    
    
    /// Setups the collectionView.
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "OperationCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "OperationCell")
        let layout = CustomFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
        
    }
    
    /// Setup the view.
    private func setupView(){
        setupCollectionView()
        setupGestures()
        toastLabel.layer.cornerRadius = 10
        operandTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
    }
    
    /// Notifies the view controller that its view was added to a view hierarchy.
    /// - Parameter animated: If true, the view was added to the window using an animation.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideToastLabel()
        
    }
    /// Setup the tap and swipe Gestures.
    private func setupGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        operationView.addGestureRecognizer(tapGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(resetCalculator))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    /// Dismiss keyboard after end editing
    @objc private func dismissKeyboard(){
        operandTextField.resignFirstResponder()
    }
    
    
    /// Reset calculator view
    @objc private func resetCalculator(){
        viewModel.resetCalculator()
    }
    
    /// Enable equalButton after check operandTextField and operation button
    @objc private func checkTextField(){
        if (operandTextField.text?.isEmpty ?? false){
            equalButton.isEnabled = false
        }else{
            if selectedButton != nil{
                equalButton.isEnabled = true
            }
        }
    }
    
    /// Hide toast label after view present
    private func hideToastLabel(){
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {[weak self] in
            self?.toastLabel.alpha = 0.0
            }, completion: {[weak self] (isCompleted) in
                self?.toastLabel.removeFromSuperview()
        })
    }
    
    /// initialize viewModel.
    private func initViewModel(){
        viewModel.updateUIClosure = { [weak self] () in
            self?.updateUI()
        }
        
        viewModel.showAlertClosure = {[weak self] () in
            guard let errorMessage = self?.viewModel.errorMessage else{return}
            self?.showAlert(message: errorMessage)
        }
    }
    
    /// Update the view after calculatation.
    private func updateUI(){
        resultLabel.text = self.viewModel.getResult()
        resetInputs()
        redoButton.isEnabled = viewModel.getOperationArrCount() == 0 ? false : true
        undoButton.isEnabled = viewModel.getOperationArrCount() == 0 ? false : true
        collectionView.reloadData()
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
    
    /// Show error alert.
    /// - Parameter message: error message to represent.
    private func showAlert(message: String?){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel) {[weak self] (_) in
            self?.resetInputs()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Reset operation Inputs
    private func resetInputs(){
        operandTextField.text = ""
        operandTextField.isEnabled = false
        equalButton.isEnabled = false
        selectedButton = nil
    }
    
    /// Detect that one of the operation buttons pressed
    /// - Parameter sender: the represent button
    @IBAction private func operationButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        switch sender.tag {
        case 0: // Undo button
            selectedButton = nil
            viewModel.undoOperation(index: 0)
        case 1: //RedoButton
            selectedButton = nil
            viewModel.redoOperation()
        default: // Arithmatic operations // 2: add // 3: sub // 4:multi // 5: div
            selectedButton = sender
            operandTextField.isEnabled = true
            equalButton.isEnabled = operandTextField.text?.isEmpty ?? false ? false : true
            operandTextField.becomeFirstResponder()
        }
        
    }
    /// Detect that equal button pressed
    /// - Parameter sender: equal button
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        guard let operand = operandTextField.text else {return}
        guard let oper = selectedButton?.titleLabel?.text else {return}
        dismissKeyboard()
        viewModel.executeOperation(operation: oper, secondOperand: operand)
    }
    
}

// MARK: - UICollectionView Protocol 
extension CalculatorVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    /// Tells the delegate that the item at the specified index path was selected.
    /// - Parameters:
    ///   - collectionView: The collection view object that is notifying you of the selection change.
    ///   - indexPath: The index path of the cell that was selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.undoOperation(index: indexPath.row)
    }
    
    /// Asks your data source object for the number of items in the specified section.
    /// - Parameters:
    ///   - collectionView: The collection view requesting this information.
    ///   - section: An index number identifying a section in collectionView. This index value is 0-based.
    /// - Returns: The number of rows in section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getOperationArrCount()
    }
    
    /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
    /// - Parameters:
    ///   - collectionView: The collection view requesting this information.
    ///   - indexPath: The index path that specifies the location of the item.
    /// - Returns: A configured cell object. You must not return nil from this method.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OperationCell", for: indexPath) as? OperationCell else {return UICollectionViewCell()}
        cell.text = viewModel.getOperation(index: indexPath.row)
        cell.maxWidth = collectionView.frame.width - 65
        return cell
    }
}

