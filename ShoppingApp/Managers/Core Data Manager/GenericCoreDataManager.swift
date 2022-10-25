//
//  GenericCoreDataManager.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 23.10.2022.
//

import UIKit
import CoreData

class GenericCoreDataManager {
    static let shared: GenericCoreDataManager = GenericCoreDataManager()
    
    private init() {
        
    }
    
    private var appDelegate: AppDelegate? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate
    }
    
    private var managedContext: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
    
    public func manageEntity(with entityManager: EntityWorker, completion: @escaping (Result<CoreDataResult, CoreDataErrors>) -> Void) {
        switch(entityManager.entityOperation) {
            
        case .getObjects:
            getEntityData(with: entityManager.entityName, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            
        case .addObject:
            createObject(with: entityManager, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            
        case .updateObject(uniqueElementKey: let uniqueElementKey, uniqueElementValue: let uniqueElementValue):
            updateEntityObject(with: entityManager, uniqueElementKey: uniqueElementKey, uniqueElementValue: uniqueElementValue, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            
        case .deleteObject(uniqueElementValue: let uniqueElementValue, elementKey: let elementVKey):
            deleteData(with: entityManager, uniqueElementValue: uniqueElementValue, uniqueElementKey: elementVKey, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            
        case .deleteAllObjects:
            deleteAllData(with: entityManager, completion: { (result: Result<CoreDataResult, CoreDataErrors>) in
                switch(result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            })
        }
    }
    
    // MARK: Core Data Manager Functions
    
    // Getting Entity Data
    private func getEntityData(with entityName: String, completion: @escaping (Result<CoreDataResult, CoreDataErrors>) -> Void) {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext?.fetch(request)
            if let results = results {
                completion(.success(.init(objectArray: results, resultMessage: "Fetching Success", isSuccess: true)))
            }
        }
        catch let error {
            completion(.failure(.errorWhenFetching(error)))
        }
    }
    
    // Creating Object
    private func createObject(with entityManager: EntityWorker, completion: (Result<CoreDataResult, CoreDataErrors>) -> Void) {
        guard let managedContext = managedContext else { return }
        guard let data = entityManager.entityObject?.entityObject else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: entityManager.entityName, in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        data.forEach({
            print($0.key, $0.value)
            object.setValue($0.value, forKeyPath: $0.key)
        })
        
        do {
            try saveContext()
            completion(.success(.init(resultMessage: "Object Created", isSuccess: true)))
        }
        catch let error {
            completion(.failure(.errorWhenSaving(error)))
        }
    }
    
    // Updating Object
    private func updateEntityObject<T: Equatable>(with entityManager: EntityWorker, uniqueElementKey: String, uniqueElementValue: T, completion: @escaping (Result<CoreDataResult, CoreDataErrors>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityManager.entityName)
        
        do {
            guard let results = try managedContext?.fetch(request) as? [NSManagedObject] else { return }
            guard let replacingObject = entityManager.entityObject?.entityObject else { return }
            
            for element in results {
                
                if((element.value(forKey: uniqueElementKey) as! T) == uniqueElementValue) {
                    replacingObject.forEach({
                        element.setValue($0.value, forKey: $0.key)
                    })
                }
            }
            do {
                try saveContext()
                completion(.success(.init(resultMessage: "Updating Success", isSuccess: true)))
            }
            catch let error {
                completion(.failure(.errorWhenSaving(error)))
            }
        }
        catch let error {
            completion(.failure(.errorWhenUpdating(error)))
        }
    }
    
    // Deleting Single Object
    private func deleteData<T: Equatable>(with entityManager: EntityWorker, uniqueElementValue: T, uniqueElementKey: String, completion: (Result<CoreDataResult, CoreDataErrors>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityManager.entityName)
        
        do {
            guard let results = try managedContext?.fetch(request) as? [NSManagedObject] else { return }
            
            for element in results {
                if(element.value(forKey: uniqueElementKey) as! T == uniqueElementValue) {
                    managedContext?.delete(element)
                }
            }
        } catch let error {
            completion(.failure(.errorWhenDeleting(error)))
        }
        do {
            try saveContext()
            completion(.success(.init(resultMessage: "Deleted Success", isSuccess: true)))
        }
        catch let error {
            completion(.failure(.errorWhenSaving(error)))
        }
    }
    
    private func deleteAllData(with entityManager: EntityWorker, completion: (Result<CoreDataResult, CoreDataErrors>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityManager.entityName)
        
        do {
            guard let results = try managedContext?.fetch(request) as? [NSManagedObject] else { return }
            
            results.forEach({
                managedContext?.delete($0)
            })
        } catch let error {
            completion(.failure(.errorWhenDeleting(error)))
        }
        do {
            try saveContext()
            completion(.success(.init(resultMessage: "All Data Deleted", isSuccess: true)))
        }
        catch let error {
            completion(.failure(.errorWhenSaving(error)))
        }
    }
    
    // Saving
    private func saveContext() throws {
        do {
            try managedContext?.save()
        } catch let error{
            throw CoreDataErrors.errorWhenSaving(error)
        }
    }
    
}
