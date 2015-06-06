//
//  Model.swift
//  lph
//
//  Created by Brit Gardner on 6/3/15.
//  Copyright (c) 2015 Brit Gardner. All rights reserved.
//

import Foundation

class Model {
    
    static var collection: [Model] = []
    
    let slug: String
    let name: String

    required init (jsonData: JSON) {
        log.info("Initializing model with \(jsonData)")
        self.slug = jsonData["slug"].string!
        self.name = jsonData["name"].string!
    }

    class func slug (slug: String) -> Model? {
        log.info("Calling this method with type of \(self)")
        var foundModel: Model?
        for model in collection {
            if model.slug == slug && model.dynamicType === self {
                foundModel = model
                break
            }
        }

        return foundModel
    }
}