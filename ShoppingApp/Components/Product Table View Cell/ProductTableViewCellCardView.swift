//
//  ProductTableViewCellCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import UIKit

class ProductTableViewCellCardView: GenericBaseView<ProductTableViewCellData> {
    // MARK: Constants
    private let spacingValue: CGFloat = 4.0
    
    // MARK: UIComponents
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .horizontal
        temp.distribution = .fill
        temp.spacing = spacingValue
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productInfoCardView: ProductInfoCardView = {
        let temp = ProductInfoCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productImage: ImageViewComponent = {
        let temp = ImageViewComponent()
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 10.0
        temp.contentMode = .scaleToFill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    // MARK: Override Methods
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productInfoCardView)
        containerStackView.addArrangedSubview(productImage)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productImage.widthAnchor.constraint(equalToConstant: 100.0),
            containerStackView.heightAnchor.constraint(equalToConstant: 120.0)
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        if let infoData = data.productInfoData {
            productInfoCardView.setData(by: infoData)
        }
        productImage.setImage(componentType: ImageViewComponentEnum.fromURL(url: data.productImage))
    }
}
