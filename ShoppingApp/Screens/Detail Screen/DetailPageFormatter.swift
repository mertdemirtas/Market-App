//
//  DetailPageFormatter.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation

class DetailPageFormatter {
    class func formatDataToProductCoreDataModel(data: ProductDetailData?) -> ProductCoreDataModel? {
        guard let data = data else { return nil}
        return ProductCoreDataModel(productName: data.productDetailCardViewData?.productInfoData?.productName, productDescription: data.productDetailCardViewData?.productInfoData?.productDescription, productPrice: data.productDetailCardViewData?.productInfoData?.productPrice, productImage: data.productDetailCardViewData?.productImage, productCount: data.productCount)
    }
    
    class func formatDataToAddToBasketComponentData(data: ProductDetailData?) -> AddToBasketCardViewData? {
        guard let data = data else { return nil }
        return AddToBasketCardViewData(productCount: data.productCount, productPrice: data.productDetailCardViewData?.productInfoData?.productPrice)
    }
}
