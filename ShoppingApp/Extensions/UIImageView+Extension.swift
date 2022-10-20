//
//  UIImageView+Extension.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import UIKit

extension UIImageView {
    func setImageWithUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
