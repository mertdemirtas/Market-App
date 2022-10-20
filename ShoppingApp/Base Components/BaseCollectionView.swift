//
//  BaseCollectionView.swift
//  Marvel App
//
//  Created by Mert Demirtaş on 2.09.2022.
//

import Foundation
import UIKit

class BaseCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func register<T: BaseCollectionViewCell>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    open func registerCell(cells: [BaseCollectionViewCell.Type]) {
        for cell in cells {
            register(cell: cell.self)
        }
    }
}
