//
//  MainScreenViewController.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import UIKit

class MainPageViewController: BaseViewController<MainPageViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
    }
}
