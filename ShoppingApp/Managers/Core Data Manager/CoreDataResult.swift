//
//  CoreDataResult.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 24.10.2022.
//

import Foundation
import CoreData

struct CoreDataResult {
    var objectArray: [NSManagedObject]?
    var resultMessage: String
    var isSuccess: Bool
    
    init(objectArray: [NSManagedObject]? = nil, resultMessage: String, isSuccess: Bool) {
        self.objectArray = objectArray
        self.resultMessage = resultMessage
        self.isSuccess = isSuccess
    }
}
