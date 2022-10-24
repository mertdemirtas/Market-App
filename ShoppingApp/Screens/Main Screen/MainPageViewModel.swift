//
//  MainScreenViewModel.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import NetworkLayerPackage

protocol MainPageViewModelDelegate: AnyObject {
    func bindBasketButtonData(totalAmount: Double?)
}

class MainPageViewModel: BaseViewModel {
    let coreDataManager = GenericCoreDataManager.shared
    let endpoint: MockDataEndpoint = MockDataEndpoint()
    
    var bindDataClosure: (() -> Void)?
    weak var delegate: MainPageViewModelDelegate?

    private var itemsArray: [MockDataModel] = []
    private var totalAmount: Double = 0
    
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
        
        for var element in data {
            if let productImage = element.productImage {
                element.productImage = convertURL(url: productImage)
            }
            self.itemsArray.append(element)
        }
        
      //  self.itemsArray = data
        bindDataClosure?()
    }
    
    func getItemCount() -> Int {
        return itemsArray.count
    }
    
    func getCellData(for indexPath: IndexPath) -> MockDataModel {
        return itemsArray[indexPath.row]
    }
    
    func getBasketAmount() {
        totalAmount = 0
        let worker = EntityWorker(entityName: "Product", entityOperation: .getObjects)
        coreDataManager.manageEntity(with: worker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
            case .success(let result):
                guard let coreDataResults = result.objectArray else { return }
                coreDataResults.forEach({
                    self?.totalAmount += Double(($0.value(forKey: "productCount") as? Int ?? 0)) * ($0.value(forKey: "productPrice") as? Double ?? 0.0)
                })
                self?.delegate?.bindBasketButtonData(totalAmount: self?.totalAmount)
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func convertURL(url: String?) -> String? {
        guard let url = url else { return nil }
        let strArr = url.components(separatedBy: "/")
        return ("https://raw.githubusercontent.com/android-getir/public-files/main/images/" + (strArr.last ?? ""))
    }
}
