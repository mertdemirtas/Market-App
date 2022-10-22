//
//  ProductDetailPageViewModel.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation

class ProductDetailPageViewModel: BaseViewModel {
    private var productDetailData: ProductDetailCardViewData
        
    init(productDetail: ProductDetailCardViewData) {
        self.productDetailData = productDetail
        super.init()
    }
    
    func getData() -> ProductDetailCardViewData? {
        return productDetailData
    }
}
