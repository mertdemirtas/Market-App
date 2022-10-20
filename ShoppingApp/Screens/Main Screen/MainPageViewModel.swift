//
//  MainScreenViewModel.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import NetworkLayerPackage

class MainPageViewModel: BaseViewModel {
    let endpoint: MockDataEndpoint = MockDataEndpoint()
    
    func getData() {
        networkManager.request(endpoint: endpoint, completionHandler: { [weak self] (result: Result<[MockDataModel], NetworkError>) in
            switch(result) {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }
}
