//
//  ProductDetailPageViewModel.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation
import CoreData

protocol ProductDetailPageViewModelDelegate: AnyObject {
    func bindData(productDetailData: ProductDetailData?)
}

class ProductDetailPageViewModel: BaseViewModel {
    private let coreDataManager = GenericCoreDataManager.shared
    
    private var detailPageData: ProductDetailData?
    private var productDetailCardData: ProductDetailCardViewData
    
    private var productCount = 0
    
    weak var delegate: ProductDetailPageViewModelDelegate?
    
    init(productDetailCardData: ProductDetailCardViewData) {
        self.productDetailCardData = productDetailCardData
        super.init()
    }
    
    func returnData() -> ProductDetailData? {
        return detailPageData
    }
    
    func getProductCount() {
        let entityWorker = EntityWorker(entityName: "Product", entityOperation: .getObjects)
        
        coreDataManager.manageEntity(with: entityWorker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
                
            case .success(let result):
                guard let object = result.objectArray else { return }
                guard let productName = self?.productDetailCardData.productInfoData?.productName else { return }
                
                if let productCount = self?.controlDataExist(object: object, productName: productName) {
                    self?.productCount = productCount
                    self?.detailPageData = ProductDetailData(productDetailCardViewData: self?.productDetailCardData, productCount: productCount)
                    self?.delegate?.bindData(productDetailData: self?.detailPageData)
                }
                else {
                    self?.productCount = 0
                    self?.detailPageData = ProductDetailData(productDetailCardViewData: self?.productDetailCardData, productCount: 0)
                    self?.delegate?.bindData(productDetailData: self?.detailPageData)
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func countDidChanged(count: Int) {
        guard var data = detailPageData else {
            return
        }
        data.productCount = count
        
        let entityWorker = EntityWorker(entityName: "Product", entityOperation: .getObjects)

        self.detailPageData = data

        if(data.productCount == 0) {
            deleteData()
            return
        }
                
        coreDataManager.manageEntity(with: entityWorker, completion: { [weak self] (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
                
            case .success(let result):
                guard let object = result.objectArray else { return }
                guard let productName = data.productDetailCardViewData?.productInfoData?.productName else { return }
                
                if let _ = self?.controlDataExist(object: object, productName: productName) {
                    self?.updateData()
                }
                else {
                    self?.addData()
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func controlDataExist(object: [NSManagedObject], productName: String) -> Int? {
        for element in object {
            if(element.value(forKey: "productName") as? String == productName) {
                let productCount = element.value(forKey: "productCount") as! Int
                return productCount
            }
        }
        return nil
    }
    
    private func addData() {
        if let formattedData = DetailPageFormatter.formatDataToProductCoreDataModel(data: detailPageData) {
            let entityObject = EntityObject(entityObject: formattedData)
            let worker = EntityWorker(entityName: "Product", entityOperation: .addObject, entityObject: entityObject)
            
            coreDataManager.manageEntity(with: worker, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    print(result.resultMessage)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    private func updateData() {
        if let formattedData = DetailPageFormatter.formatDataToProductCoreDataModel(data: detailPageData) {
            let entityObject = EntityObject(entityObject: formattedData)
            let worker = EntityWorker(entityName: "Product", entityOperation: .updateObject(uniqueElementKey: "productName", uniqueElementValue: formattedData.productName ?? ""), entityObject: entityObject)
            
            coreDataManager.manageEntity(with: worker, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    print(result.resultMessage)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    private func deleteData() {
        if let formattedData = DetailPageFormatter.formatDataToProductCoreDataModel(data: detailPageData) {
            let entityObject = EntityObject(entityObject: formattedData)
            let worker = EntityWorker(entityName: "Product", entityOperation: .deleteObject(uniqueElementValue: formattedData.productName ?? "", elementKey: "productName"), entityObject: entityObject)
            
            coreDataManager.manageEntity(with: worker, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    print(result.resultMessage)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
