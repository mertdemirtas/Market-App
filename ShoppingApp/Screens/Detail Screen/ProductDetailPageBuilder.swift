//
//  ProductDetailPageBuilder.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import UIKit

class ProductDetailPageBuilder {
    class func build(productDetail: ProductDetailCardViewData) -> UIViewController {
        let viewModel = ProductDetailPageViewModel(productDetail: productDetail)
        let vc = ProductDetailPageViewController(viewModel: viewModel)
        return vc
    }
}
