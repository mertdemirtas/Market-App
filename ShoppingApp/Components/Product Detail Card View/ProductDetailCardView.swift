//
//  ProductDetailCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import UIKit

class ProductDetailCardView: GenericBaseView<ProductDetailCardViewData> {
    
    // MARK: UIComponents
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.distribution = .fill
        temp.spacing = 20.0
        temp.axis = .vertical
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productImage: ImageViewComponent = {
        let temp = ImageViewComponent()
        temp.contentMode = .scaleToFill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productInfoCardView: ProductInfoCardView = {
        let temp = ProductInfoCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    // MARK: Override Methods
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productImage)
        containerStackView.addArrangedSubview(productInfoCardView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productImage.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        productInfoCardView.setData(by: data.productInfoData)
        
        productImage.setImage(componentType: ImageViewComponentEnum.fromURL(url: "https://raw.githubusercontent.com/android-getir/public-files/main/images/60801eada9eb26c147b8e494_tr_1619794759098.jpeg"))
    }
}
