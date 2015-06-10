//
//  Player.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/7/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class Player: Object {

    dynamic var id = ""
    let characters = List<Character>()

    override class func primaryKey() -> String? {
        return "id"
    }

}