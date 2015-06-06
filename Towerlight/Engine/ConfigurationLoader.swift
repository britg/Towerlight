//
//  ConfigurationLoader.swift
//  lph
//
//  Created by Brit Gardner on 6/2/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation
import XCGLogger

class ConfigurationLoader {
    
    let modelMapping: [String: Model.Type] = [
        "Slot": Slot.self
    ]
    
    func loadAll () {
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
        
        // Looking up by slug
        log.info("Collection of slots is \(Slot.collection)")
        if let slot = Slot.slug("dex") {
            log.info("Look up by slug is \(slot.slug)")
        }
        
        // Creating Equipment
//        let equipmentGenerator = EquipmentGenerator()
//        let equipment = equipmentGenerator.generate()
//        log.info("Equipment is \(equipment)")
    }
    
    func loadFile (path: String) {
        let data = NSData(contentsOfFile: path)
        let contents = JSON(data: data!)
        if let type = contents["type"].string {
            if let modelClass = modelMapping[type] {
                let modelInst = modelClass(jsonData: contents)
                Model.collection.append(modelInst)
                log.info("model inst is \(modelInst)")
            }
        }
    }
}