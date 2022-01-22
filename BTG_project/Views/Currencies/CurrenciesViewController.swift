//
//  CurrenciesViewController.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import UIKit

class CurrenciesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    var viewModel = CurrenciesViewModel()
    
    var originCurrency = false
    
    weak var delegate: CurrencyDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingOverlay.shared.showOverlay(view: self.view)
        edgesForExtendedLayout = []
        setupTableView()
        fetchData()
        setupNavBar()
        setupSearchBar()
    }
    
    // MARK: - Setup
    func setupNavBar() {
        self.title = "Moedas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Setup Functions
    func setupTableView() {
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self        
    }
    
    func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Buscar moeda"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        navigationItem.titleView = searchBar
    }
    
    func fetchData() {
        viewModel.fetchList(success: {
            self.tableView.reloadData()
            self.finishLoading()
        }, error: { errorMessage in
            self.finishLoading()
            let modalViewController = CustomAlertViewController(title: "Error", description: errorMessage,
                                                                firstButtonText: "Try Again", secondButtonText: "Ok",
                                                                firstButtonAction: {
                                                                    self.fetchData()
            })
            modalViewController.modalPresentationStyle = .overCurrentContext
            self.present(modalViewController, animated: true, completion: nil)
        })
    }
    
    func finishLoading() {
        LoadingOverlay.shared.hideOverlayView()
    }
}

// MARK: - Cells
extension CurrenciesViewController {
    
    func cell(for model: Any, in tableView: UITableView, index: IndexPath) -> UITableViewCell {
        if let model = model as? CurrencyModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: index) as? CurrencyCell
            cell?.configCell(data: model)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}

// MARK: - UITablewView Delegate e SataSource
extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currenciesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.currencyForIndex(indexPath.row)
        return cell(for: model as Any, in: tableView, index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let initials = viewModel.currencyForIndex(indexPath.row).initials ?? ""
        
        originCurrency ? delegate?.onOriginCurrencySelected(currency: initials) : delegate?.onDestinyCurrencySelected(currency: initials)


        guard let nav = self.navigationController else { return }
        nav.popViewController(animated: true)
    }
}

extension CurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredCurrencies(searchText: searchText)
        tableView.reloadData()
    }
}
