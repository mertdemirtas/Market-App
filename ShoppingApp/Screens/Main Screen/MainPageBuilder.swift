//
//  MainScreenBuilder.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import UIKit

class MainPageBuilder {
    class func build() -> UIViewController {
        let viewModel = MainPageViewModel()
        let viewController = MainPageViewController(viewModel: viewModel)
        viewController.title = "Shopping App"
        return viewController
    }
}
