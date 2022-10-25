//
//  AddToBasketCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 22.10.2022.
//

import Foundation
import UIKit

protocol AddToBasketCardViewDelegate: AnyObject {
    func countDidChanged(currentCount: Int)
}

class AddToBasketCardView: GenericBaseView<AddToBasketCardViewData> {
    
    weak var delegate: AddToBasketCardViewDelegate?
    
    private var removeButtonAction: (() -> Void) = { }
    private var addButtonAction: (() -> Void) = { }
    
    lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.distribution = .fillProportionally
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
        temp.contentMode = .bottom
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
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func setupViewConfigurations() {
        removeFromBasketButton.setButtonAction { [weak self] in
            guard let data = self?.returnData() else { return }
            
            guard let productCount = data.productCount else { return }
            
            if(productCount >= 1) {
                let updatedProductCount = productCount - 1
                self?.setData(by: AddToBasketCardViewData(productCount: updatedProductCount, productPrice: data.productPrice))
                self?.loadDataView()
                self?.delegate?.countDidChanged(currentCount: updatedProductCount)
            }
            self?.removeButtonAction()
        }
        
        addToBasketButton.setButtonAction { [weak self] in
            guard let data = self?.returnData() else { return }
            
            let updatedProductCount = (data.productCount ?? 0) + 1
            
            self?.setData(by: AddToBasketCardViewData(productCount: updatedProductCount, productPrice: data.productPrice))
            self?.loadDataView()
            self?.delegate?.countDidChanged(currentCount: updatedProductCount)
            self?.addButtonAction()

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
    
    public func setAddButtonAction(action: @escaping () -> Void) {
        addButtonAction = action
    }
    
    public func setRemoveButtonAction(action: @escaping () -> Void) {
        removeButtonAction = action
    }
}
