//
//  BasketProductCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation
import UIKit

class BasketProductCardView: GenericBaseView<BasketProductCardViewData> {
    
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.distribution = .fill
        temp.spacing = 8.0
        temp.axis = .horizontal
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productInfoCardView: ProductInfoCardView = {
        let temp = ProductInfoCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var basketView: BaseView = {
        let temp = BaseView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    lazy var addToBasketCardView: AddToBasketCardView = {
        let temp = AddToBasketCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productInfoCardView)
        containerStackView.addArrangedSubview(basketView)
        basketView.addSubview(addToBasketCardView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            addToBasketCardView.centerYAnchor.constraint(equalTo: basketView.centerYAnchor),
            addToBasketCardView.leadingAnchor.constraint(equalTo: basketView.leadingAnchor),
            addToBasketCardView.trailingAnchor.constraint(equalTo: basketView.trailingAnchor),
            
            basketView.widthAnchor.constraint(equalToConstant: 70.0),
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        if let productData = data.productInfoData {
            productInfoCardView.setData(by: productData)
        }
        addToBasketCardView.setData(by: data.addToBasketData)
    }
}
