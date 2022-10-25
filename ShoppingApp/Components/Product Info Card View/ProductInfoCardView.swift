//
//  ProductInfoCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import UIKit

class ProductInfoCardView: GenericBaseView<ProductInfoCardViewData> {
    // MARK: Constants
    private let spacingValue: CGFloat = 4.0
    
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.distribution = .fillProportionally
        temp.spacing = spacingValue
        temp.axis = .vertical
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productName: BaseLabel = {
        let temp = BaseLabel()
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 16)
        temp.contentMode = .top
        temp.textColor = .black
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productDescription: BaseLabel = {
        let temp = BaseLabel()
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 12)
        temp.contentMode = .top
        temp.textColor = .darkGray
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productPrice: BaseLabel = {
        let temp = BaseLabel()
        temp.numberOfLines = 1
        temp.font = .systemFont(ofSize: 16)
        temp.textColor = .systemIndigo
        temp.contentMode = .bottom
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productName)
        containerStackView.addArrangedSubview(productDescription)
        containerStackView.addArrangedSubview(productPrice)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        if let productName = data.productName {
            self.productName.text = productName
        }
        
        if let productDescription = data.productDescription {
            self.productDescription.text = productDescription
        }
        
        if let productPriceString = data.productPrice {
            productPrice.text = "₺"
            productPrice.addText(text: String(productPriceString))
        }
    }
}
