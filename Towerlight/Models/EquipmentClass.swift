//
//  EquipmentClass.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/8/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class EquipmentClass: Model {
    dynamic var key = ""
    dynamic var name = ""

    override static func primaryKey() -> String? {
        return "key"
    }

    override func build(json: JSON) {
        self.key = json["key"].string!
        self.name = json["name"].string!
    }

}