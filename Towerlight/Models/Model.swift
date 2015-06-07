//
//  Model.swift
//  lph
//
//  Created by Brit Gardner on 6/3/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation

class Model {

    class func find (type: String, withKey: String) -> NSFNanoObject? {
        let search = NSFNanoSearch(store: DataStore.store)
        search.key = withKey
//        search.match = NSFEqualTo
        let results: [String: NSFNanoObject] = search.searchObjectsWithReturnType(NSFReturnObjects, error: nil) as! [String: NSFNanoObject]
        return results[withKey]
    }

}