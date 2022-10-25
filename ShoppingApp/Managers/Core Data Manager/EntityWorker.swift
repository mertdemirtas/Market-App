//
//  EntityManagerWorker.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 23.10.2022.
//

import Foundation

struct EntityWorker {
    let entityName: String
    let entityOperation: EntityOperations
    let entityObject: EntityObject?
    
    init(entityName: String, entityOperation: EntityOperations, entityObject: EntityObject? = nil) {
        self.entityName = entityName
        self.entityOperation = entityOperation
        self.entityObject = entityObject
    }
}
