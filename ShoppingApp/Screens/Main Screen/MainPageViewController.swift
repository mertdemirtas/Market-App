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
        temp.setData(by: ShoppingCardButtonData(basketAmount: 20.0))
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var tableView: BaseTableView = {
        let temp = BaseTableView()
        temp.dataSource = self
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBarItems()
        viewModel.getData()
        prepareTableView()
        
    }
    private func prepareNavigationBarItems() {
        let rightBarItem = UIBarButtonItem(customView: buttonCard)
        rightBarItem.customView?.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
    }
    
    private func prepareTableView() {
        tableView.registerCell(cells: [ProductTableViewCell.self])
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.bindDataClosure =  { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
        let data = viewModel.getCellData(for: indexPath)
        cell.setData(data: ProductTableViewCellData(productImage: data.productImage, productName: data.productName, productPrice: data.productPrice, productDescription: data.productDescription))
        cell.genericView.reloadViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadInputViews()
            }
        }
        return cell
    }
}
