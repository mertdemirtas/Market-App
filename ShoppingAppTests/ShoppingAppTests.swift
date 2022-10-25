//
//  ShoppingAppTests.swift
//  ShoppingAppTests
//
//  Created by Erdem Perşembe on 12.04.2022.
//

import XCTest
import Foundation
@testable import ShoppingApp

class ShoppingAppTests: XCTestCase {
    var viewModel: MainPageViewModel?
    
    var data: [MockDataModel] = []
    
    override func setUpWithError() throws {
        viewModel = MainPageViewModel()
        
        if let decodedData = decodeJson(fileName: "MockData") {
            data = decodedData
        }
    }
    
    override func tearDownWithError() throws {
    }
    
    func testMainPageViewModelItemCount() throws {
        // when
        let itemCount = viewModel?.getItemCount()
        
        // then
        XCTAssertEqual(itemCount, data.count)
    }
    
    func testMainPageViewModelItem() throws {
        // when
        let productName = viewModel?.getCellData(for: IndexPath(row: 0, section: 0))?.productInfoData?.productName
        
        // then
        XCTAssertEqual(productName, data.first?.productName)
    }
    
    func decodeJson(fileName: String?) -> [MockDataModel]? {
        var tempData: [MockDataModel] = []
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .deferredToDate
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        
        do {
            if let filePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                
                do {
                    tempData = try jsonDecoder.decode([MockDataModel].self, from: data)
                    tempData.forEach({
                        viewModel?.setDataObject(data: $0)
                    })
                    return tempData
                }
                catch let error {
                    print(error)
                }
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}

    
