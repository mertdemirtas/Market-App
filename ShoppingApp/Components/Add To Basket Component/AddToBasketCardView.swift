//
//  AddToBasketCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 22.10.2022.
//

import Foundation
import UIKit

class AddToBasketCardView: GenericBaseView<AddToBasketCardViewData> {
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.distribution = .fillEqually
        temp.axis = .vertical
        temp.spacing = 5.0
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var basketOperationStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .horizontal
        temp.distribution = .fillEqually
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var removeFromBasketButton: BaseButton<GenericDataProtocol> = {
        let temp = BaseButton<GenericDataProtocol>()
        temp.backgroundColor = .systemIndigo
        temp.buttonLabel.text = "-"
        temp.buttonLabel.font = .boldSystemFont(ofSize: 18)
        temp.buttonLabel.textAlignment = .center
        temp.buttonLabel.textColor = .white
        temp.addViewOnCenter(view: temp.buttonLabel)
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 10.0
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productCount: BaseLabel = {
        let temp = BaseLabel()
        temp.backgroundColor = .white
        temp.textColor = .black
        temp.textAlignment = .center
        temp.font = .boldSystemFont(ofSize: 18)
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 5.0
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var addToBasketButton: BaseButton<GenericDataProtocol> = {
        let temp = BaseButton<GenericDataProtocol>()
        temp.backgroundColor = .systemIndigo
        temp.buttonLabel.text = "+"
        temp.buttonLabel.font = .boldSystemFont(ofSize: 18)
        temp.buttonLabel.textAlignment = .center
        temp.buttonLabel.textColor = .white
        temp.addViewOnCenter(view: temp.buttonLabel)
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 10.0
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productAmount: BaseLabel = {
        let temp = BaseLabel()
        temp.textAlignment = .center
        temp.textColor = .systemIndigo
        temp.font = .boldSystemFont(ofSize: 18)
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 10.0
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(basketOperationStackView)
        containerStackView.addArrangedSubview(productAmount)
        
        basketOperationStackView.addArrangedSubview(removeFromBasketButton)
        basketOperationStackView.addArrangedSubview(productCount)
        basketOperationStackView.addArrangedSubview(addToBasketButton)
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            containerStackView.widthAnchor.constraint(equalToConstant: 120.0),
            containerStackView.heightAnchor.constraint(equalToConstant: 70.0)
        ])
    }
    
    override func setupViewConfigurations() {
        removeFromBasketButton.setButtonAction {
            
        }
        
        addToBasketButton.setButtonAction {
            
        }
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        
        if let productCountData = data.productCount {
            productCount.text = "\(productCountData)"
            
            guard let productPrice = data.productPrice else { return }
            productAmount.text = "₺\(productPrice * Double(productCountData))"
        }
        else {
            productCount.text = "0"
        }
    }
}
