//
//  HomeViewController.swift
//  BTG_project
//
//  Created by matheus.s.franca on 20/08/21.
//

import UIKit

class HomeViewController: UIViewController, CurrencyDelegate {
    
    @IBOutlet weak var originCurrencyButton: UIButton!
    @IBOutlet weak var destinyCurrencyButton: UIButton!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var calculateCurrencyButton: UIButton!
    @IBOutlet weak var outdatedLabel: UILabel!
    
    let viewModel = HomeViewModel()
    
    var originCurrency = "BRL"
    var destinyCurrency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupLayout()
        setupNavBar()
        outdatedLabel.text = "* Os dados podem estar desatualizados devido a falta de internet"
    }
    
    func setupNavBar() {
        self.title = "Conversor de Moedas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupLayout() {
        setupButton(button: originCurrencyButton, text: originCurrency)
        setupButton(button: destinyCurrencyButton, text: destinyCurrency)
        setupButton(button: calculateCurrencyButton, text: "Calcular")
        setupTextField()
    }
    
    func setupButton(button: UIButton, text: String) {
        button.backgroundColor = .themeColor
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.setTitle(text, for: .normal)
    }
    
    func setupTextField() {
        valueTextField.placeholder = "10"
        valueTextField.keyboardType = .numberPad
        valueTextField.textAlignment = .center
    }
    
    @IBAction func goToOriginCurrency(_ sender: Any) {
        guard let nav = self.navigationController else { return }
        AppCoordinator.goToCurrencyList(parent: nav, delegate: self, originCurrency: true)
    }
    
    @IBAction func goToDestinyCurrency(_ sender: Any) {
        guard let nav = self.navigationController else { return }
        AppCoordinator.goToCurrencyList(parent: nav, delegate: self, originCurrency: false)
    }
    
    @IBAction func calculateCurrency(_ sender: Any) {
        fetchData()
    }
    
    func fetchData() {
        guard let value = valueTextField.text, let doubleValue = Double(value) else {
            errorAlert(message: "Campo de texto inválido")
            return
        }
        LoadingOverlay.shared.showOverlay(view: self.view)
        viewModel.fetchList(originCurrency: originCurrency, destinyCurrency: destinyCurrency, value: doubleValue) {
            self.finishLoading()
            self.convertedValueLabel.text = self.viewModel.convertedValue
            self.outdatedLabel.isHidden = self.viewModel.isConnected
        } error: { errorMessage in
            self.finishLoading()
            let modalViewController = CustomAlertViewController(title: "Error", description: errorMessage,
                                                                firstButtonText: "Try Again", secondButtonText: "Ok",
                                                                firstButtonAction: {
                                                                    self.fetchData()
            })
            modalViewController.modalPresentationStyle = .overCurrentContext
            self.present(modalViewController, animated: true, completion: nil)
        }
    }
    
    func finishLoading() {
        LoadingOverlay.shared.hideOverlayView()
    }
    
    func onOriginCurrencySelected(currency: String) {
        originCurrency = currency
        originCurrencyButton.setTitle(currency, for: .normal)
    }
    
    func onDestinyCurrencySelected(currency: String) {
        destinyCurrency = currency
        destinyCurrencyButton.setTitle(currency, for: .normal)
    }
}
