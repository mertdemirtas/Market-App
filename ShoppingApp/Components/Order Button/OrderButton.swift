//
//  PlaceOrderButton.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation

class OrderButton: BaseButton<GenericDataProtocol> {
    
    override func addMajorViewComponents() {
        addViewOnCenter(view: self.buttonLabel)
    }
    
    override func setupViewConfigurations() {
        backgroundColor = .systemIndigo
        layer.masksToBounds = true
        layer.cornerRadius = 10.0
        
        self.buttonLabel.text = "Order"
        self.buttonLabel.font = .boldSystemFont(ofSize: 21)
        self.buttonLabel.textAlignment = .center
        self.buttonLabel.textColor = .white
    }
}
