//
//  CoreDataHandler.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import CoreData

struct  CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyMediaApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of data store failed \(error)")
            }
            
        }
         return container
    }()
   
    func createUserDetails(firstName: String, lastName: String, email: String, password: String, dateOfBirth: Date) -> NewUserData? {
        
        let context = persistentContainer.viewContext
        let userdata = NSEntityDescription.insertNewObject(forEntityName: "NewUserData", into: context) as! NewUserData
        userdata.firstName = firstName
        userdata.lastName = lastName
        userdata.email = email
        userdata.password = password
        userdata.dateOfBirth = dateOfBirth
        
        do {
            try context.save()
            return userdata
        } catch let createError {
            print("failed to create the user data: \(createError)")
        }
        return nil
    }
    
    func fetchUserDetails() -> [NewUserData]? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NewUserData>(entityName: "NewUserData")
        
        do {
            let details = try context.fetch(fetchRequest)
            return details
        } catch let fetchError {
            print("Failed to fetch data of the new user: \(fetchError)")
        }
        return nil
    }
    
    
    func fetchUserDetails(withEmail email: String) -> NewUserData? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NewUserData>(entityName: "NewUserData")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let details = try context.fetch(fetchRequest)
            return details.first
        } catch let fetchError {
            print("Failed to fetch User details: \(fetchError)")
        }
        return nil
    }
    
    func deleteUserDetails(userdetails: NewUserData){
        
        let context = persistentContainer.viewContext
        context.delete(userdetails)
        
        do {
            try context.save()
        } catch let saveError {
            print ("Failed to delete data of the user: \(saveError)")
        }
        
    }
    
    
}

