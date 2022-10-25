//
//  CoreDataErrors.swift
//  ShoppingApp
//
//  Created by Mert Demirtaş on 23.10.2022.
//

enum CoreDataErrors: Error {
    case errorWhenEncoding(Error)
    case errorWhenSaving(Error)
    case errorWhenDeleting(Error)
    case errorWhenFetching(Error)
    case errorWhenUpdating(Error)
}
