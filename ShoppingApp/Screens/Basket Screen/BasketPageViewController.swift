//
//  BasketPageViewController.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation
import UIKit

class BasketPageViewController: BaseViewController<BasketPageViewModel> {
    // MARK: UIComponents
    private lazy var tableView: BaseTableView = {
        let temp = BaseTableView()
        temp.dataSource = self
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var orderFieldCardView: OrderFieldCardView = {
        let temp = OrderFieldCardView()
        temp.delegate = self
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        viewModel.delegate = self
        viewModel.getData()
    }
    
    private func prepareTableView() {
        tableView.registerCell(cells: [BasketProductTableViewCell.self])
    }
    
    override func addViewComponents() {
        view.addSubview(tableView)
        view.addSubview(orderFieldCardView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: orderFieldCardView.topAnchor),
            
            orderFieldCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            orderFieldCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            orderFieldCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            orderFieldCardView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}

// MARK: Extensions
extension BasketPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsCount = viewModel.getItemCount() else { return 0 }
        return itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketProductTableViewCell", for: indexPath) as? BasketProductTableViewCell else { return UITableViewCell() }
        
        cell.genericView.addToBasketCardView.setAddButtonAction {
            self.viewModel.increaseProductCount(indexPath: indexPath)
        }
        
        cell.genericView.addToBasketCardView.setRemoveButtonAction {
            self.viewModel.decreaseProductCount(indexPath: indexPath)
        }
        
        guard let data = viewModel.getElement(by: indexPath) else { return cell }
        cell.setData(data: data)
        return cell
    }
}

extension BasketPageViewController: BasketPageViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            let totalAmount = self.viewModel.getTotalAmount()
            
            if(totalAmount == 0.0) {
                self.orderFieldCardView.isHidden = true
                return
            }
            self.orderFieldCardView.isHidden = false
            self.orderFieldCardView.setData(by: OrderFieldCardViewData(totalAmount: self.viewModel.getTotalAmount()))
        }
    }
    
    func orderSuccessful(successMessage: String?) {
        let alert = UIAlertController(title: "Order Successfull!", message: successMessage, preferredStyle: .alert)
        self.present(alert, animated: true)
        
        // Asynchronous operations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension BasketPageViewController: OrderFieldCardViewDelegate {
    func orderButtonTapped() {
        viewModel.orderItems()
    }
}
