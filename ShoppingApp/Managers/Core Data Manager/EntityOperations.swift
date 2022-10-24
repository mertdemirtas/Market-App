//
//  EntityOperations.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 23.10.2022.
//

import Foundation

enum EntityOperations {
    case getObjects
    case addObject
    case updateObject(uniqueElementKey: String, uniqueElementValue: Any)
    case deleteObject(uniqueElementValue: Any, elementKey: String)
    case deleteAllObjects
}
