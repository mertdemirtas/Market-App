//
//  BasketPageFormatter.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 25.10.2022.
//

import Foundation
import CoreData

struct BasketPageFormatter {
    
    static func formatDataToProductCoreDataModel(data: BasketProductCardViewData?) -> ProductCoreDataModel? {
        guard let data = data else { return nil}
        return ProductCoreDataModel(productName: data.productInfoData?.productName, productDescription: data.productInfoData?.productDescription, productPrice: data.productInfoData?.productPrice, productImage: "", productCount: data.addToBasketData?.productCount)
    }
    
    static func formatDataToBasketProductCardViewData(nsObject: [NSManagedObject]?) -> [BasketProductCardViewData]? {
        guard let nsObject = nsObject else { return nil }
        
        var formattedData: [BasketProductCardViewData] = []

        for element in nsObject {
            let productName = element.value(forKey: "productName") as? String
            let productDescripton = element.value(forKey: "productDescription") as? String
            let productPrice = element.value(forKey: "productPrice") as? Double
            let productImage = element.value(forKey: "productImage") as? String
            let productCount = element.value(forKey: "productCount") as? Int
            
            let temp = BasketProductCardViewData(productInfoData: ProductInfoCardViewData(productName: productName, productDescription: productDescripton, productPrice: productPrice), addToBasketData: AddToBasketCardViewData(productCount: productCount, productPrice: productPrice))
            formattedData.append(temp)
        }
        return formattedData
    }
}
