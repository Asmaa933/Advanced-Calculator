//
//  CalculatorVC.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet var operationView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet var operandTextField: UITextField!
    @IBOutlet private var equalButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    private var selectedButton: UIButton?{
        didSet{
            oldValue?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectedButton?.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
    
    private lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
    }
    
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "OperationCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "OperationCell")
        let layout = CustomFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
        
    }
    
    private func setupView(){
        setupCollectionView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        operationView.addGestureRecognizer(gesture)
        operandTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
    }
    
    @objc private func dismissKeyboard(){
        operandTextField.resignFirstResponder()
    }
    
    @objc private func checkTextField(){
        if (operandTextField.text?.isEmpty ?? false){
            equalButton.isEnabled = false
        }else{
            if selectedButton != nil{
                equalButton.isEnabled = true
            }
        }
        
    }
    
    private func initViewModel(){
        viewModel.updateUIClosure = { [weak self] () in
            self?.updateUI()
        }
        
        
        viewModel.showAlertClosure = {[weak self] () in
            self?.showAlert(message: self?.viewModel.errorMessage)
            
        }
    }
    
    private func updateUI(){
        resultLabel.text = self.viewModel.getResult()
        resetInputs()
        redoButton.isEnabled = viewModel.getOperationArrCount() == 0 ? false : true
        undoButton.isEnabled = viewModel.getOperationArrCount() == 0 ? false : true
        collectionView.reloadData()
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
    
    private func showAlert(message: String?){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel) {[weak self] (_) in
            self?.resetInputs()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func resetInputs(){
        operandTextField.text = ""
        operandTextField.isEnabled = false
        equalButton.isEnabled = false
        selectedButton = nil
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        switch sender.tag {
        case 0: // Undo button
            selectedButton = nil
            viewModel.undoOperation(index: 0)
        case 1: //RedoButton
            selectedButton = nil
            viewModel.redoOperation()
        default: // Arithmatic operations
            selectedButton = sender
            operandTextField.isEnabled = true
            equalButton.isEnabled = operandTextField.text?.isEmpty ?? false ? false : true
            operandTextField.becomeFirstResponder()
        }
        
    }
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        guard let operand = operandTextField.text else {return}
        guard let oper = selectedButton?.titleLabel?.text else {return}
        dismissKeyboard()
        viewModel.executeOperation(operation: oper, secondOperand: operand)
    }
    
}
extension CalculatorVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.undoOperation(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getOperationArrCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OperationCell", for: indexPath) as? OperationCell else {return UICollectionViewCell()}
        cell.text = viewModel.getOperation(index: indexPath.row)
        cell.maxWidth = collectionView.frame.width - 65
        return cell
    }
}

