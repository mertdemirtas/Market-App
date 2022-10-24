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
    
    let coreDataManager = GenericCoreDataManager.shared
    
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .vertical
        temp.distribution = .fill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getProductCount()
    }
    
    override func addViewComponents() {
        view.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productDetailCardView)
        view.addSubview(addToBasketCardView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.bottomAnchor.constraint(lessThanOrEqualTo: addToBasketCardView.topAnchor),
            
            addToBasketCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addToBasketCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addToBasketCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addToBasketCardView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
}

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
