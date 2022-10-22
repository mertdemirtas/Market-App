//
//  LoadingViewComponentContainerView.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import UIKit

class LoadingViewComponent: UIActivityIndicatorView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func startLoading() {
        DispatchQueue.main.async {
            self.startAnimating()
        }
    }
    
    public func stopLoading() {
        DispatchQueue.main.async {
            self.stopAnimating()
            self.removeFromSuperview()
        }
    }
}
