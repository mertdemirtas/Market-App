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
        temp.spacing = 4.0
        temp.axis = .horizontal
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productTableViewCellCardView: ProductTableViewCellCardView = {
        let temp = ProductTableViewCellCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var addToBasketCardView: AddToBasketCardView = {
        let temp = AddToBasketCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productTableViewCellCardView)
        containerStackView.addArrangedSubview(addToBasketCardView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        productTableViewCellCardView.setData(by: data.productData)
        addToBasketCardView.setData(by: data.addToBasketData)
    }
}
