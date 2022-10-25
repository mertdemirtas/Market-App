//
//  BasketPageViewModel.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation

protocol BasketPageViewModelDelegate: AnyObject {
    func reloadData()
    func orderSuccessful(successMessage: String?)
}

class BasketPageViewModel: BaseViewModel {
    private let coreDataManager = GenericCoreDataManager.shared
    
    private var itemsArray: [BasketProductCardViewData] = []
    
    weak var delegate: BasketPageViewModelDelegate?
    
    public func getData() {
        let worker = EntityWorker(entityName: "Product", entityOperation: .getObjects)
        
        coreDataManager.manageEntity(with: worker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
                
            case .success(let result):
                guard let nsManagedObject = result.objectArray else { return }
                
                let formattedData = BasketPageFormatter.formatDataToBasketProductCardViewData(nsObject: nsManagedObject)
                self?.bindTableViewData(itemsArray: formattedData)
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    public func bindTableViewData(itemsArray: [BasketProductCardViewData]?) {
        guard let itemsArray = itemsArray else { return }
        self.itemsArray = itemsArray
        self.delegate?.reloadData()
    }
    
    public func getItemCount() -> Int? {
        return itemsArray.count
    }
    
    public func getElement(by indexPath: IndexPath) -> BasketProductCardViewData? {
        return itemsArray[indexPath.row]
    }
    
    public func getTotalAmount() -> Double? {
        var totalAmount = 0.0
        for element in itemsArray {
            guard let productCount = element.addToBasketData?.productCount else { return totalAmount }
            guard let productPrice = element.addToBasketData?.productPrice else { return totalAmount }
            totalAmount += (productPrice) * Double(productCount)
        }
        return totalAmount
    }
    
    public func orderItems() {
        let worker = EntityWorker(entityName: "Product", entityOperation: .deleteAllObjects)
        coreDataManager.manageEntity(with: worker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
                
            case .success(let result):
                self?.delegate?.orderSuccessful(successMessage: result.resultMessage)
                self?.itemsArray = []
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    public func increaseProductCount(indexPath: IndexPath) {
        guard var productCount = itemsArray[indexPath.row].addToBasketData?.productCount else { return }
        productCount += 1
        itemsArray[indexPath.row].addToBasketData?.productCount = productCount
        
        if let formattedData = BasketPageFormatter.formatDataToProductCoreDataModel(data: itemsArray[indexPath.row]) {
            updateData(formattedData: formattedData)
        }
    }
    
    public func decreaseProductCount(indexPath: IndexPath) {
        guard var productCount = itemsArray[indexPath.row].addToBasketData?.productCount else { return }
        if(productCount == 1) {
            deleteData(indexPath: indexPath)
            return
        }
        productCount -= 1
        itemsArray[indexPath.row].addToBasketData?.productCount = productCount
        
        if let formattedData = BasketPageFormatter.formatDataToProductCoreDataModel(data: itemsArray[indexPath.row]) {
            updateData(formattedData: formattedData)
        }
    }
    
    private func updateData(formattedData: ProductCoreDataModel?) {
        
        let entityObject = EntityObject(entityObject: formattedData)
        let worker = EntityWorker(entityName: "Product", entityOperation: .updateObject(uniqueElementKey: "productName", uniqueElementValue: formattedData?.productName ?? ""), entityObject: entityObject)
        
        coreDataManager.manageEntity(with: worker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
            case .success(_):
                self?.getData()
            case .failure(let error):
                print(error)
            }
        })
        
    }
    
    private func deleteData(indexPath: IndexPath) {
        if let formattedData = BasketPageFormatter.formatDataToProductCoreDataModel(data: itemsArray[indexPath.row]) {
            
            let entityObject = EntityObject(entityObject: formattedData)
            let worker = EntityWorker(entityName: "Product", entityOperation: .deleteObject(uniqueElementValue: formattedData.productName ?? "", elementKey: "productName"), entityObject: entityObject)
            
            coreDataManager.manageEntity(with: worker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(_):
                    self?.getData()
                case .failure(let error):
                    print(error)
                }
            })
            
        }
    }
}
