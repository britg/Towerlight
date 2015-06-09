//
//  Slot.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/7/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class Slot: Object {
    dynamic var key = ""
    dynamic var name = ""

    override static func primaryKey() -> String? {
        return "key"
    }

    class func generate (json: JSON) -> Slot {
        let slot = Slot()
        slot.key = json["key"].string!
        slot.name = json["name"].string!
        return slot
    }

}