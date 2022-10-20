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
    
    private var itemsArray: [MockDataModel] = []
    
    var bindDataClosure: (() -> Void)?
    
    func getData() {
        networkManager.request(endpoint: endpoint, completionHandler: { [weak self] (result: Result<[MockDataModel], NetworkError>) in
            switch(result) {
            case .success(let data):
                self?.bindData(data: data)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func bindData(data: [MockDataModel]?) {
        guard let data = data else { return }
        self.itemsArray = data
        bindDataClosure?()
    }
    
    func getItemCount() -> Int {
        return itemsArray.count
    }
    
    func getCellData(for indexPath: IndexPath) -> MockDataModel {
        return itemsArray[indexPath.row]
    }
}
