//
//  Setting.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/9/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class Settting: Object {
    dynamic var key = ""
    dynamic var value = ""

    override class func primaryKey () -> String? {
        return "key"
    }
}