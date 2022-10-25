//
//  BaseViewController.swift
//  Taxi App
//
//  Created by Mert Demirtaş on 7.04.2022.
//

import UIKit
import NetworkLayerPackage

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    var viewModel: T!
    let nav = UINavigationBarAppearance()
    
    // MARK: - ActivityIndicator
    private lazy var loadingViewComponent: LoadingViewComponent = {
        let frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        let temp = LoadingViewComponent(frame: frame)
        temp.color = .spinnerColor
        temp.style = .large
        temp.backgroundColor = .clear
        guard let applicationWindowCenter = self.view.window?.center else { return temp }
        temp.center = applicationWindowCenter
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    convenience init(viewModel: T) {
        self.init()
        self.viewModel = viewModel
        viewModel.networkStateDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewControllerConfigurations()
        prepareNavigationBar()
        addViewComponents()
    }
    
    private func prepareViewControllerConfigurations() {
        self.view.backgroundColor = .appBackgroundColor
    }
    
    private func prepareNavigationBar() {
        nav.backgroundColor = .navBarColor
        
        nav.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 32, weight: .medium)]
        
        let navBar = self.navigationController?.navigationBar
        
        navBar?.tintColor = .white
        navBar?.isTranslucent = true
        navBar?.standardAppearance = nav
        navBar?.scrollEdgeAppearance = nav
        navBar?.compactAppearance = nav
        }
    
    func addViewComponents() { }
}

extension BaseViewController: BaseViewModelNetworkStateDelegate {
    func networkStateChanged(networkState: NetworkStates) {
        switch(networkState) {
        case .processing:
            DispatchQueue.main.async {
                self.view.window?.addSubview(self.loadingViewComponent)
                self.loadingViewComponent.startLoading()
            }
        case .done:
            DispatchQueue.main.async {
                self.loadingViewComponent.stopLoading()
            }
        case .error(_):
            DispatchQueue.main.async {
                self.loadingViewComponent.stopLoading()
            }
        }
    }
}
