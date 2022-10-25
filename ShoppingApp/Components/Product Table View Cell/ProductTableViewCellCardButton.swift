//
//  ProductTableViewCellCardButton.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation
import UIKit

class ProductTableViewCellCardButton: BaseButton<ProductTableViewCellData> {
    private lazy var productTableViewCellCardView: ProductTableViewCellCardView = {
        let temp = ProductTableViewCellCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        addSubview(productTableViewCellCardView)
        
        NSLayoutConstraint.activate([
            productTableViewCellCardView.topAnchor.constraint(equalTo: topAnchor),
            productTableViewCellCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productTableViewCellCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productTableViewCellCardView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        productTableViewCellCardView.setData(by: data)
    }
}
