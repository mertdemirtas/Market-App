//
//  ProductDetailPageViewController.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation
import UIKit

class ProductDetailPageViewController: BaseViewController<ProductDetailPageViewModel> {
    
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
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func addViewComponents() {
        view.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productDetailCardView)
        containerStackView.addArrangedSubview(addToBasketCardView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            addToBasketCardView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
    
    private func bindData() {
        let data = viewModel.getData()
        productDetailCardView.setData(by: data)
        addToBasketCardView.setData(by: AddToBasketCardViewData(productCount: 1, productPrice: data?.productInfoData?.productPrice))
    }
}
