//
//  AppDelegate.swift
//  Towerlight
//
//  Created by Brit Gardner on 6/6/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import UIKit
import XCGLogger

let log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        ensureDatabase()
        let loader = ConfigurationLoader()
        loader.loadAll()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func databaseURL() -> NSURL? {

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

    func ensureDatabase () {
        let dbUrl = databaseURL()
        let nanoStore = NSFNanoStore.createAndOpenStoreWithType(NSFPersistentStoreType, path: dbUrl!.path, error: nil)
        log.info("Nano store is \(nanoStore)")
    }

}

