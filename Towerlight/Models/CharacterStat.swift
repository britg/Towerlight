//
//  CharacterStat.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/9/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class CharacterStat: Object {

    dynamic var character: Character?
    dynamic var stat: Stat?
    dynamic var value: Double = 0.0
}