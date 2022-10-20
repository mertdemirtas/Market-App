//
//  BaseCollectionViewCell.swift
//  Marvel App
//
//  Created by Mert Demirtaş on 2.09.2022.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addMajorViewComponents()
        setupViewConfigurations()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addMajorViewComponents()
        setupViewConfigurations()
    }
    
    func setupViewConfigurations() { }
    func addMajorViewComponents() { }
}
