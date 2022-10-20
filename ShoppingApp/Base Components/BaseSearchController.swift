//
//  BaseSearchController.swift
//  MovieApp
//
//  Created by Mert Demirtaş on 23.06.2022.
//

import UIKit

class BaseSearchController<T>: UISearchController {
    
    var viewModel: T!
    var vSpinner : UIView?
    
    init(viewModel: T) {
        super.init(searchResultsController: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewControllerConfigurations()
        prepareSearchControllerConfigurations()
    }
    
    func prepareSearchControllerConfigurations() { }
    func prepareViewControllerConfigurations() { }
}

