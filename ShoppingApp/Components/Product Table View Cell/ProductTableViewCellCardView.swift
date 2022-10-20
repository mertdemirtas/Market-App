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
    private let spacingValue: CGFloat = 8.0
    var reloadViewClosure: (() -> Void)?
    
    // MARK: UIComponents
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.distribution = .fillProportionally
        temp.axis = .horizontal
        temp.spacing = spacingValue
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productDetailStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .vertical
        temp.spacing = spacingValue
        temp.distribution = .fill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productName: BaseLabel = {
        let temp = BaseLabel()
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 19)
        temp.textColor = .black
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productDescription: BaseLabel = {
        let temp = BaseLabel()
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 17)
        temp.textColor = .darkGray
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productPrice: BaseLabel = {
        let temp = BaseLabel()
        temp.font = .systemFont(ofSize: 19)
        temp.textColor = .systemIndigo
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productImage: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFit
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    // MARK: Override Methods
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productDetailStackView)
        containerStackView.addArrangedSubview(productImage)
        
        productDetailStackView.addArrangedSubview(productName)
        productDetailStackView.addArrangedSubview(productDescription)
        productDetailStackView.addArrangedSubview(productPrice)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productImage.widthAnchor.constraint(equalToConstant: 120.0)
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        productName.text = data.productName
        productDescription.text = data.productDescription
        productPrice.text = String(describing: data.productPrice)
        
//        guard let imageURL = URL(string: data.productImage ?? "") else { return }
//
//            // just not to cause a deadlock in UI!
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.productImage.image = image
//                self.reloadViewClosure?()
//            }
//        }
    }
}
