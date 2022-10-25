//
//  MainScreenViewController.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import UIKit

class MainPageViewController: BaseViewController<MainPageViewModel> {
        
    private lazy var buttonCard: ShoppingCardButton = {
        let temp = ShoppingCardButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var tableView: BaseTableView = {
        let temp = BaseTableView()
        temp.dataSource = self
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bindBasketButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        prepareNavigationBarItems()
        prepareTableView()
        
        viewModel.getData()
        
        bindData()
    }
    
    private func prepareNavigationBarItems() {
        let rightBarItem = UIBarButtonItem(customView: buttonCard)
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
    }
    
    private func prepareTableView() {
        tableView.registerCell(cells: [ProductTableViewCell.self])
    }
    
    private func bindData() {
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.bindDataClosure =  { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func bindBasketButton() {
        viewModel.getBasketAmount()
    }
    
    override func addViewComponents() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        if let formattedData = viewModel.getCellData(for: indexPath) {
            cell.setData(data: formattedData)
            
            cell.genericView.setButtonAction { [weak self] in
                let vc = ProductDetailPageBuilder.build(productDetail: ProductDetailCardViewData(productInfoData: formattedData.productInfoData, productImage: formattedData.productImage))
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        return cell
    }
}

extension MainPageViewController: MainPageViewModelDelegate {
    func bindBasketButtonData(totalAmount: Double?) {
        buttonCard.setData(by: ShoppingCardButtonData(basketAmount: totalAmount))
    }
}

