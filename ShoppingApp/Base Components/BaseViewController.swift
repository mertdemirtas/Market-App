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
    lazy var activityIndicator: UIActivityIndicatorView = {
        let temp = UIActivityIndicatorView()
        temp.style = .large
        temp.color = .spinnerColor
        temp.backgroundColor = .clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        guard let applicationWindowCenter = self.view.window?.center else { return temp }
        temp.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        temp.center = applicationWindowCenter
        return temp
    }()
    
    convenience init(viewModel: T) {
        self.init()
        self.viewModel = viewModel
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
                self.view.window?.addSubview(self.activityIndicator)
            }
        case .done:
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.activityIndicator.stopAnimating()
            }
        case .error(_):
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
