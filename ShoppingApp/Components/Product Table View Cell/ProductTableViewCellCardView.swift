//
//  ProductTableViewCellCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import UIKit

class ProductTableViewCellCardView: BaseButton<ProductTableViewCellData> {
    // MARK: Constants
    private let spacingValue: CGFloat = 4.0
    var reloadViewClosure: (() -> Void)?
    
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
    
    private lazy var productImage: UIImageView = {
        let temp = UIImageView()
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
        productInfoCardView.setData(by: ProductInfoCardViewData(productName: data.productName, productDescription: data.productDescription, productPrice: data.productPrice))
        
        guard let imageURL = URL(string: "https://raw.githubusercontent.com/android-getir/public-files/main/images/5f36a28b29d3b131b9d95548_tr_1637858193743.jpeg") else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.productImage.image = image
          //      self.reloadViewClosure?()
            }
        }
    }
}
