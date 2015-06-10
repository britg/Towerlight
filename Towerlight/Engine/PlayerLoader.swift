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

    init () {
        realm = Realm()
    }

    func getCurrentPlayerId () -> String? {
        var playerId: String?
        if let player = realm.objects(Player).first {
            return player.id
        }
        return playerId
    }

    func ensurePlayer () {

        if let currentPlayerId = getCurrentPlayerId() {
            log.info("Player exists \(currentPlayerId)")
            return
        }

        let player = Player()
        player.id = NSUUID().UUIDString
        addCharacters(player)

        realm.write {
            self.realm.add(player, update: false)
        }

    }

    func addCharacters (player: Player) {
        let character = Character()

        let charClass = realm.objects(CharacterClass).filter("key='warrior'")
        character.characterClass = charClass.first
        player.characters.append(character)
    }
}