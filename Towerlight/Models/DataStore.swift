//
//  DataStore.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/7/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation

class DataStore {
    static var store: NSFNanoStore = {
        log.info("I'm creating a data store")
        return NSFNanoStore.createAndOpenStoreWithType(NSFPersistentStoreType, path: DataStore.databasePath(), error: nil)
    }()

    class func ensureDatabase () {
        let store = DataStore.store
    }

    class func databasePath() -> String? {
        return databaseURL()!.path
    }

    class func databaseURL() -> NSURL? {

        let fileManager = NSFileManager.defaultManager()

        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)

        if let documentDirectory: NSURL = urls.first as? NSURL {
            // This is where the database should be in the documents directory
            let finalDatabaseURL = documentDirectory.URLByAppendingPathComponent("towerlight.db")

            if finalDatabaseURL.checkResourceIsReachableAndReturnError(nil) {
                // The file already exists, so just return the URL
                return finalDatabaseURL
            } else {
                // Copy the initial file from the application bundle to the documents directory
                if let bundleURL = NSBundle.mainBundle().URLForResource("towerlight", withExtension: "db") {
                    let success = fileManager.copyItemAtURL(bundleURL, toURL: finalDatabaseURL, error: nil)
                    if success {
                        return finalDatabaseURL
                    } else {
                        println("Couldn't copy file to final location!")
                    }
                } else {
                    println("Couldn't find initial database in the bundle!")
                }
            }
        } else {
            println("Couldn't get documents directory!")
        }
        
        return nil
    }
}