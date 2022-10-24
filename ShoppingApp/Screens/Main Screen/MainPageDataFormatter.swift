//
//  MainPageDataFormatter.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation

struct MainPageDataFormatter {
    static func formatDataToProductTableViewCellData(data: MockDataModel?) -> ProductTableViewCellData? {
        guard let data = data else { return nil }
        return ProductTableViewCellData(productInfoData: ProductInfoCardViewData(productName: data.productName, productDescription: data.productDescription, productPrice: data.productPrice), productImage: data.productImage)
    }
}
