//
//  BasketProductCardViewData.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation

struct BasketProductCardViewData: Codable {
    let productData: ProductTableViewCellData?
    let addToBasketData: AddToBasketCardViewData?
}
