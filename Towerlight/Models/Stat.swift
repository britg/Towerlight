//
//  Stat.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/9/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class Stat: Model {
    dynamic var key = ""
    dynamic var name = ""
    dynamic var abbr = ""

    override class func primaryKey() -> String? {
        return "key"
    }

    override func build(json: JSON) {
        self.key = json["key"].string!
        self.name = json["name"].string!
        self.abbr = json["abbr"].string!
    }
}