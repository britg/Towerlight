//
//  Equipment.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/9/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class Equipment: Object {
    dynamic var name = ""
    dynamic var slot: Slot?
    dynamic var characterSlot: CharacterSlot?
}