//
//  CalculatorVC.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet var operandTextField: UITextField!
    
    @IBOutlet private var equalButton: UIButton!
    
    private var selectedButton: UIButton?
    private lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        initViewModel()
    }
    
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "OperationCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "OperationCell")
        
    }
    
    private func initViewModel(){
        viewModel.updateUIClosure = { [weak self] () in
            guard let self = self else {return}
            self.resultLabel.text = self.viewModel.getResult()
            self.operandTextField.text = ""
            self.selectedButton?.backgroundColor = .white
            self.collectionView.reloadData()
        }
        
        
        viewModel.showAlertClosure = {[weak self] () in
            guard let self = self else {return}
            self.showAlert(message: self.viewModel.errorMessage)
        }
    }
    
    private func showAlert(message: String?){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        selectedButton?.backgroundColor = .white
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        default:
            selectedButton = sender
            sender.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            equalButton.isEnabled = false
        }
        
    }
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        guard let operand = operandTextField.text else {return}
        guard let oper = selectedButton?.titleLabel?.text else {return}
        viewModel.executeOperation(operation: oper, secondOperand: operand)
    }
    
}
extension CalculatorVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getOperationArrCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OperationCell", for: indexPath) as? OperationCell else {return UICollectionViewCell()}
        cell.text = viewModel.getOperation(atIndex: indexPath)
        return cell
    }
    
    
}
