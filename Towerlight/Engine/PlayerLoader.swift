//
//  PlayerManager.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/7/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import RealmSwift

class PlayerLoader {

    var realm: Realm
    var config: JSON?
    var player: Player?

    init (_ config: JSON) {
        realm = Realm()
        self.config = config
    }

    func loadExistingPlayer () {
        self.player = realm.objects(Player).first
    }

    func createNewPlayer () {
        self.player = Player()
    }

    func loadExistingOrCreatePlayer () {
        loadExistingPlayer()

        if self.player == nil {
            createNewPlayer()
        }
    }

    func ensurePlayer () {
        loadExistingOrCreatePlayer()
        generateCharacters()

        realm.write {
            self.realm.add(self.player!, update: false)
        }

    }

    func generateCharacters () {
        let chars = self.config!["start_classes"].arrayObject as! [String]
        for char in chars {
            generateCharacter(char)
        }
    }

    func generateCharacter (className: String) {
        let character = Character()

        let charClass = realm.objects(CharacterClass).filter("key='\(className)'")
        character.characterClass = charClass.first
        self.player!.characters.append(character)
    }
}