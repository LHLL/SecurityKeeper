//
//  PersistentManager.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import CoreData

class PersistentManager {
    
    static var shared = PersistentManager()
    private var assets:[NSManagedObject] = []
    private var dbQueue = DispatchQueue(label: "DataBaseQueue")
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SecurityKeeper")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func selfCheck(){
        let credential = load(entity:"Credential")
        if credential.count == 0 {
            saveCredential()
        }else{
            if let first = credential.first {
                EncryptionManager.pass = first.value(forKey: "password") as! String
                EncryptionManager.iv = first.value(forKey: "iv") as! String
            }
            self.assets = load(entity:"Asset")
        }
    }
    
    func save(fileName:String,data:Data) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Asset",
                                                in: managedContext)!
        let cre = NSManagedObject(entity: entity,
                                  insertInto: managedContext)
        
        cre.setValue(fileName, forKeyPath: "title")
        cre.setValue(data, forKeyPath: "data")
        do {
            try managedContext.save()
            self.assets.append(cre)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func load(entity:String)->[NSManagedObject]{
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

//Mark:Methods will be invoked only once
extension PersistentManager {
    private func saveCredential(){
        let result = generateCredential()
        EncryptionManager.pass = result.0
        EncryptionManager.iv = result.1
        
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Credential",
                                                in: managedContext)!
        let cre = NSManagedObject(entity: entity,
                                  insertInto: managedContext)
        
        cre.setValue(result.0, forKeyPath: "password")
        cre.setValue(result.1, forKeyPath: "iv")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func generateCredential()->(String,String) {
        let characterPool = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-=+_#$%@&*."
        var count = 0
        var pass = ""
        var iv = ""
        while count < 16 {
            defer{count += 1}
            let index1 = UInt32(arc4random_uniform(52))
            let index2 = UInt32(arc4random_uniform(52))
            pass.append(characterPool[characterPool.index(characterPool.startIndex,
                                                          offsetBy: String.IndexDistance(index1))])
            iv.append(characterPool[characterPool.index(characterPool.startIndex,
                                                        offsetBy: String.IndexDistance(index2))])
        }
        return (pass,iv)
    }
}
