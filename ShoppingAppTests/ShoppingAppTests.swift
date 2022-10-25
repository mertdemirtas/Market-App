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
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .deferredToDate
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        
        do {
            if let filePath = Bundle(for: type(of: self)).path(forResource: "MockData", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                
                do {
                    self.data = try jsonDecoder.decode([MockDataModel].self, from: data)
                    self.data.forEach({
                        viewModel?.setDataObject(data: $0)
                    })
                }
                catch let error {
                    print(error)
                }
            }
        } catch {
            print("error: \(error)")
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
}
