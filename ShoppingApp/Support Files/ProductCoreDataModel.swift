//
//  ProductCoreDataModel.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 23.10.2022.
//

import Foundation

struct ProductCoreDataModel: Codable {
    let productName: String?
    let productDescription: String?
    let productPrice: Double?
    let productImage: String?
    let productCount: Int?
}
