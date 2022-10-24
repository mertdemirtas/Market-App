//
//  ShoppingCardButton.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import UIKit

class ShoppingCardButton: BaseButton<ShoppingCardButtonData> {
    
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .horizontal
        temp.distribution = .fill
        temp.spacing = 3.0
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var BasketImageView: BaseView = {
        let temp = BaseView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var basketImage: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "basketIcon")
        temp.contentMode = .scaleAspectFit
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var basketAmountLabel: BaseLabel = {
        let temp = BaseLabel()
        temp.textColor = .black
        temp.font = .boldSystemFont(ofSize: 17)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    func upgradeAmount(totalAmount: Double?) {
        if let totalAmount = totalAmount {
            basketAmountLabel.text = "\(totalAmount)"
        }
        else {
            basketAmountLabel.text = nil
            basketAmountLabel.removeFromSuperview()
        }
    }
    
    override func addMajorViewComponents() {
        backgroundColor = .white
        layer.cornerRadius = 5.0
        
        addSubview(containerStackView)

        containerStackView.addArrangedSubview(basketImage)
        containerStackView.addArrangedSubview(basketAmountLabel)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 3.0),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3.0),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3.0),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3.0),
            
            basketImage.heightAnchor.constraint(equalToConstant: 25.0),
            basketImage.widthAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        guard let basketAmount = data.basketAmount else { return }
        
        basketAmountLabel.text = "₺\(basketAmount)"
    }
}
