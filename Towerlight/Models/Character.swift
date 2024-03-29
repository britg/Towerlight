//
//  Character.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/7/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class Character: Object {

    dynamic var name = ""
    dynamic var characterClass: CharacterClass?
    let slots = List<CharacterSlot>()
    let stats = List<CharacterStat>()

}