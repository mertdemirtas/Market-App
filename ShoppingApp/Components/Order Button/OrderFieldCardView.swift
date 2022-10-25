//
//  PlaceOrderButtonCardView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation
import UIKit

protocol OrderFieldCardViewDelegate: AnyObject {
    func orderButtonTapped()
}

class OrderFieldCardView: GenericBaseView<OrderFieldCardViewData> {
    weak var delegate: OrderFieldCardViewDelegate?
    
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .horizontal
        temp.spacing = 16.0
        temp.distribution = .fill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var orderButton: BaseButton<GenericDataProtocol> = {
        let temp = BaseButton<GenericDataProtocol>()
        temp.backgroundColor = .systemIndigo
        temp.buttonLabel.text = "Order"
        temp.buttonLabel.font = .boldSystemFont(ofSize: 21)
        temp.buttonLabel.textAlignment = .center
        temp.buttonLabel.textColor = .white
        temp.addViewOnCenter(view: temp.buttonLabel)
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = 10.0
        temp.setButtonAction { [weak self] in
            self?.delegate?.orderButtonTapped()
        }
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var totalAmountLabel: BaseLabel = {
        let temp = BaseLabel()
        temp.textAlignment = .center
        temp.textColor = .black
        temp.font = .boldSystemFont(ofSize: 17)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(orderButton)
        containerStackView.addArrangedSubview(totalAmountLabel)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        if let totalAmount = data.totalAmount {
            totalAmountLabel.text = "₺\(totalAmount)"
        }
        else {
            totalAmountLabel.text = "0"
        }
    }
}
