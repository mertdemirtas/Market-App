//
//  MockDataEndpoint.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 20.10.2022.
//

import Foundation
import NetworkLayerPackage

class MockDataEndpoint: Endpoint {
    var networkConstants: NetworkConstants = MockDataNetworkConstants()
    var httpMethod: HTTPMethods = .get
    var path: String?
    var headers: [String : String]? = nil
    var body: [String : Any]? = nil
    
    init() {
        path = "/6bb59bbc-e757-4e71-9267-2fee84658ff2"
    }
}
