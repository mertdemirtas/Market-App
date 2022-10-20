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
        temp.distribution = .fillEqually
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
        temp.backgroundColor = .lightGray
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
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(basketImage)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            basketImage.heightAnchor.constraint(equalToConstant: 20.0),
            basketImage.widthAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    override func loadDataView() {
        guard let data = returnData() else { return }
        guard let basketAmount = data.basketAmount else { return }
        
        containerStackView.addArrangedSubview(basketAmountLabel)
        basketAmountLabel.text = "\(basketAmount)"
    }
}
