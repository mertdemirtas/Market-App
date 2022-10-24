//
//  EntityObject.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 23.10.2022.
//

import Foundation

struct EntityObject {
    var entityObject: [String: Any]?
    
    init<T: Codable>(entityObject: T) {
        encodeObject(entityObject, completionHandler: { (result: Result<[String:Any], Error>) in
            switch(result) {
            case .success(let data):
                self.entityObject = data
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension EntityObject {
    private func encodeObject<T: Codable>(_ value: T, completionHandler: (Result<[String: Any], Error>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(value)
            let dictionaryObject = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
            completionHandler(.success(dictionaryObject))
        }
        catch let error {
            completionHandler(.failure(CoreDataErrors.errorWhenEncoding(error)))
        }
    }
}
