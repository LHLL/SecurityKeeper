//
//  PersistentManager.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import RealmSwift

class PersistentManager {
    static var shared = PersistentManager()
    
    private var db:Realm
    private var dbQueue = DispatchQueue(label: "DataBaseQueue")
    
    private init() {
        db = try! Realm()
        let credential = db.objects(Credential.self)
        if credential.count == 0 {
            saveCredential()
        }else{
            if let first = credential.first {
                EncryptionManager.pass = first.password
                EncryptionManager.iv = first.iv
            }
        }
    }
    
    private func saveCredential(){
        let result = generateCredential()
        EncryptionManager.pass = result.0
        EncryptionManager.iv = result.1
        let credential = Credential()
        credential.password = result.0
        credential.iv = result.1
        dbQueue.sync {
            try! db.write {
                db.add(credential)
            }
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
