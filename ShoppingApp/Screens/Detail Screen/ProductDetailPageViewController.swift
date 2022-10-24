//
//  ProductDetailPageViewController.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 21.10.2022.
//

import Foundation
import UIKit
import CoreData

class ProductDetailPageViewController: BaseViewController<ProductDetailPageViewModel> {
    
    let coreDataManager = GenericCoreDataManager.shared
    
    private lazy var containerStackView: UIStackView = {
        let temp = UIStackView()
        temp.axis = .vertical
        temp.distribution = .fill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var productDetailCardView: ProductDetailCardView = {
        let temp = ProductDetailCardView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var addToBasketCardView: AddToBasketCardView = {
        let temp = AddToBasketCardView()
        temp.contentMode = .bottom
        temp.delegate = self
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getProductCount()
        //        let salo = EntityManagerWorker.init(entityName: "Product", entityOperation: .getObjects)
        
        //        coreDataManager.deleteAllData(with: salo, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
        //            print(result)
        //
        //        })
        
        //        let dictionaryData = ["productName": "BCA", "productDescription": "Desc", "productImage": "empty", "productCount": 5, "productPrice": 12.5] as [String : Any]
        //
        //        let dictionaryDataa = ["productName": "ABC" , "productDescription": "Desc", "productImage": "empty", "productCount": 32 , "productPrice": 12.5] as [String : Any]
        //
        let object = ProductCoreDataModel(productName: "Name", productDescription: "Desc", productPrice: 2, productImage: "img", productCount: 1)
        let entityObject = EntityObject.init(entityObject: object)
        //
//        let worker = EntityWorker.init(entityName: "Product", entityOperation: .getObjects, entityObject: entityObject)
        //
        let salo = EntityWorker.init(entityName: "Product", entityOperation: .getObjects)
        
        //        coreDataManager.createObject(with: worker, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
        //
        //        })
        
//        coreDataManager.updateEntityObject(with: worker, uniqueElementKey: "productPrice", uniqueElementValue: 1.2, completion: {  (result: Result<CoreDataResult, CoreDataErrors>) in
//
//        })
//
//        coreDataManager.manageEntity(with: salo, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
//            switch(result) {
//
//            case .success(let result):
//                print(result.objectArray)
//            case .failure(let error):
//                print(error)
//            }
//
//        })
        //
        //        coreDataManager.manageEntity(with: worker, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
        //            switch(result) {
        //            case .success(let data):
        //                let data = data.objectArray
        //                print(data)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        })
        
        //        print(salo.entityObject, salo.entityName, salo.entityOperation)
        //        print(worker.entityName, worker.entityOperation, worker.entityObject)
        
        //        coreDataManager.createEntity(entityName: "Product", data: dictionaryData)
        //        coreDataManager.createEntity(entityName: "Product", data: dictionaryDataa)
        
        //        do {
        //            try coreDataManager.updateEntity(entityName: "Product", uniqueDataAttributeName: "productName", uniqueData: "ABC", data: dictionaryData)
        //
        //        }
        //
        //        catch {
        //
        //        }
        
        //        coreDataManager.getEntityData(entityName: "Product", completion: { (result: Result<[NSFetchRequestResult]?, Error>) in
        //            switch(result) {
        //
        //            case .success(let data):
        //                guard let _ = data else { return }
        //                print(data as Any)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        })
    }
    
    override func addViewComponents() {
        view.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(productDetailCardView)
        view.addSubview(addToBasketCardView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.bottomAnchor.constraint(lessThanOrEqualTo: addToBasketCardView.topAnchor),
            
            addToBasketCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addToBasketCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addToBasketCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addToBasketCardView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
}

extension ProductDetailPageViewController: ProductDetailPageViewModelDelegate {
    func bindData(productDetailData: ProductDetailData?) {
        productDetailCardView.setData(by: productDetailData?.productDetailCardViewData)
        
        let addToBasketComponentData = DetailPageFormatter.formatDataToAddToBasketComponentData(data: productDetailData)
        
        addToBasketCardView.setData(by: addToBasketComponentData)
    }
}

extension ProductDetailPageViewController: AddToBasketCardViewDelegate {
    func countDidChanged(currentCount: Int) {
        viewModel.countDidChanged(count: currentCount)
        
        let salo = EntityWorker.init(entityName: "Product", entityOperation: .getObjects)

        coreDataManager.manageEntity(with: salo, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
            switch(result) {
            case .success(let data):
                let data = data.objectArray
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }
}
