//
//  Folder.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import RealmSwift

class Folder: Object {
    @objc dynamic var name = ""
    var contents:AnyRealmCollection<DataModel>?
}
