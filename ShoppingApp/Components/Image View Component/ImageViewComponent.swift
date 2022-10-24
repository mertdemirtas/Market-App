//
//  ImageViewComponent.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 22.10.2022.
//

import Foundation
import UIKit

class ImageViewComponent: UIImageView {
    private let imageCache = NSCache<NSString, UIImage>()
    
    private var componentType: ImageViewComponentEnum?
    
    private lazy var loadingViewComponent: LoadingViewComponent = {
        let frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let temp = LoadingViewComponent(frame: frame)
        temp.color = .black
        temp.style = .medium
        temp.backgroundColor = .clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    func setImage(componentType: ImageViewComponentEnum?) {
        self.componentType = componentType
        checkComponentType()
    }
    
    private func checkComponentType() {
        guard let componentType = componentType else { return
            
        }
        switch(componentType) {
        case .fromURL(url: let url):
            loadImageFromURL(imageURLString: url)
            
        case .fromAssets(assetName: let assetName):
            if let assetName = assetName {
                image = UIImage(named: assetName)
            }
        }
    }
    
    private func loadImageFromURL(imageURLString: String?) {
        addLoadingViewComponent()
        loadingViewComponent.startLoading()
        
        guard let imageURLString = imageURLString else { return }
        guard let imageURL = URL(string: imageURLString) else { return }
        
        if let cacheImage = ImageCacheManager.returnImagesFromCache(key: imageURLString) {
            print(cacheImage)
            self.image = cacheImage
            self.loadingViewComponent.stopLoading()
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            if let tempImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.image = tempImage
                    ImageCacheManager.setImagesToCache(object: tempImage, key: imageURLString)
                    self.loadingViewComponent.stopLoading()
                }
            }
        }
    }
    
    private func addLoadingViewComponent() {
        addSubview(loadingViewComponent)
        
        NSLayoutConstraint.activate([
            loadingViewComponent.topAnchor.constraint(equalTo: topAnchor),
            loadingViewComponent.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingViewComponent.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingViewComponent.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
