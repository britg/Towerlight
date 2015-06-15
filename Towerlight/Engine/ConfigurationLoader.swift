//
//  ConfigurationLoader.swift
//  lph
//
//  Created by Brit Gardner on 6/2/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import XCGLogger
import RealmSwift

class ConfigurationLoader {

    var loadedConfigs: [String: JSON] = [String: JSON]()
    var objs: [Model] = [Model]()

    let configLoadingStages = [
        0: ["Stat", "Slot", "EquipmentClass", "CharacterClass"],
        1: ["PlayerConfig"]
    ]

    func bootstrap () {
        loadConfiguration()
    }

    func loadConfiguration () {

        let realm = Realm()
        log.info(realm.path)

        loadConfigs()
        parseConfigs()
    }

    func loadConfigs () {
        log.info("Loading all config files")

        let path = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("config")
        let en: NSDirectoryEnumerator = NSFileManager.defaultManager().enumeratorAtPath(path)!
        
        for file in en {
            var isDir: ObjCBool = false
            let fullPath = path.stringByAppendingPathComponent(file as! String)
            NSFileManager.defaultManager().fileExistsAtPath(fullPath, isDirectory: &isDir)
            
            if !isDir {
                loadFile(fullPath)
            }
        }
    }
    
    func loadFile (path: String) {
        let data = NSData(contentsOfFile: path)
        let contents = JSON(data: data!)

        if let type = contents["type"].string {
            loadedConfigs[type] = contents
        }
    }

    func parseConfigs () {
        for (stage, types) in configLoadingStages {
            for type in types {
                parseConfig(type, loadedConfigs[type]!)
            }
            flushObjects()
        }
    }

    func flushObjects () {
        let realm = Realm()
        realm.write {
            for obj in self.objs {
                realm.add(obj, update: true)
            }
        }
        self.objs = []
    }

    func parseConfig (type: String, _ config: JSON) {
        var obj: Model? = nil
        switch type {
            case "Slot":
                obj = Slot()
            case "EquipmentClass":
                obj = EquipmentClass()
            case "Stat":
                obj = Stat()
            case "CharacterClass":
                obj = CharacterClass()
            case "PlayerConfig":
                loadPlayer(config)
            default:
                log.info("type not defined \(type)")
        }
        if obj != nil {
            obj!.build(config)
            objs.append(obj!)
        }
    }

    func loadPlayer (config: JSON) {
        let playerLoader = PlayerLoader(config)
        playerLoader.ensurePlayer()
    }
}