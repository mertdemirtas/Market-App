//
//  GenericCollectionViewCell.swift
//  Marvel App
//
//  Created by Mert Demirtaş on 2.09.2022.
//

import UIKit

class GenericCollectionViewCell<Data, View: GenericBaseView<Data>>: BaseCollectionViewCell {
    // MARK: Constants
    private let spacingValue: CGFloat = 0
    
    var genericView: View = {
        let temp = View()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViewComponents() {
        self.contentView.addSubview(genericView)
    }
    
    override func setupViewConfigurations() {
        NSLayoutConstraint.activate([
            genericView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: spacingValue),
            genericView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: spacingValue),
            genericView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: spacingValue),
            genericView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: spacingValue)
        ])
    }
    
    func setData(data: Data) {
        genericView.setData(by: data)
    }
}
