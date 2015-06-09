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

    var objs: [Object] = [Object]()

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

        let realm = Realm()
        realm.write {
            for obj in self.objs {
                realm.add(obj, update: true)
            }
        }

    }
    
    func loadFile (path: String) {
        let data = NSData(contentsOfFile: path)
        let contents = JSON(data: data!)
        if let type = contents["type"].string {
            var obj: Object? = nil
            log.info("type is \(type)")
            switch type {
                case "Slot":
                    log.info("Generating slot with \(contents)")
                    obj = Slot.generate(contents) as Object
                    log.info("slot is \(obj)")
                default:
                    log.info("type not defined \(type)")
            }
            if obj != nil {
                objs.append(obj!)
            }
        }


    }
}