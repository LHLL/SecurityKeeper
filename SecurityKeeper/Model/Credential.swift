//
//  Credential.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import RealmSwift

class Credential: Object {
    @objc dynamic var password = ""
    @objc dynamic var iv = ""
}
