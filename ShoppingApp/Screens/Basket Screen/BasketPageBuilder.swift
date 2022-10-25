//
//  BasketPageBuilder.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import UIKit

class BasketPageBuilder {
    class func build() -> UIViewController {
        let viewModel = BasketPageViewModel()
        let vc = BasketPageViewController(viewModel: viewModel)
        return vc
    }
}
