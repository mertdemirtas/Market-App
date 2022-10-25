//
//  ProductDetailPageViewController.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation
import UIKit
import CoreData

class ProductDetailPageViewController: BaseViewController<ProductDetailPageViewModel> {
    // MARK: UIComponents
    private lazy var productDetailCardView: ProductDetailCardView = {
        let temp = ProductDetailCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var addToBasketCardView: AddToBasketCardView = {
        let temp = AddToBasketCardView()
        temp.contentMode = .bottom
        temp.delegate = self
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getProductCount()
    }
    
    override func addViewComponents() {
        view.addSubview(productDetailCardView)
        
        view.addSubview(addToBasketCardView)
        
        NSLayoutConstraint.activate([
            productDetailCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productDetailCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productDetailCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productDetailCardView.bottomAnchor.constraint(lessThanOrEqualTo: addToBasketCardView.topAnchor),
            
            addToBasketCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            addToBasketCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            addToBasketCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addToBasketCardView.heightAnchor.constraint(equalToConstant: 80.0),
        ])
    }
}

// MARK: Extensions
extension ProductDetailPageViewController: ProductDetailPageViewModelDelegate {
    func bindData(productDetailData: ProductDetailData?) {
        productDetailCardView.setData(by: productDetailData?.productDetailCardViewData)
        
        let addToBasketComponentData = DetailPageFormatter.formatDataToAddToBasketComponentData(data: productDetailData)
        
        addToBasketCardView.setData(by: addToBasketComponentData)
    }
}

extension ProductDetailPageViewController: AddToBasketCardViewDelegate {
    func countDidChanged(currentCount: Int) {
        viewModel.countDidChanged(count: currentCount)
    }
}
