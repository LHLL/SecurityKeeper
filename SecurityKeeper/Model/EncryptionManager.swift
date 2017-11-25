//
//  EncryptionManager.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import CryptoSwift

struct EncryptionManager {
    
    static var pass:String = ""
    
    static var iv:String = ""
    
    private init(){}
    
    static func encrypt(_ input:Data)->Data?{
        do{
            let encpryted = try AES(key: Array(pass.utf8),
                                    blockMode: .CBC(iv: Array(iv.utf8)),
                                    padding: .pkcs7).encrypt([UInt8](input))
            return Data(bytes: encpryted)
        }catch let error {
            print(error)
        }
        return nil
    }
    
    static func decrypt(_ input:Data)->Data? {
        do{
            let decrypted = try AES(key: Array(pass.utf8),
                                     blockMode: .CBC(iv: Array(iv.utf8)),
                                     padding: .pkcs7).decrypt([UInt8](input))
            return Data(bytes: decrypted)
        }catch let error{
            print(error)
        }
        return nil
    }
}
