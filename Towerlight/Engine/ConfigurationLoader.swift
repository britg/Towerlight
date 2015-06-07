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
    
    let modelMapping: [String: NSFNanoObject.Type] = [
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

//        DataStore.store.closeWithError(nil)

        let mainHand = Model.find("Slot", withKey: "main_hand")
        log.info("main hand is \(mainHand) \(mainHand.dynamicType)")


    }
    
    func loadFile (path: String) {
        let data = NSData(contentsOfFile: path)
        let contents = JSON(data: data!)
        if let type = contents["type"].string {
            if let modelType = modelMapping[type] {
                let modelInst = modelType(dictionary: contents.dictionaryObject, key: contents["slug"].string!)
                DataStore.store.addObject(modelInst, error: nil)
                log.info("model inst is \(modelInst)")
            }
        }
    }
}