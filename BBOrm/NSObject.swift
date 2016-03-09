//
//  NSObject.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 08/03/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

extension NSObject {
    /// Returns `true` if the class has the property for us to get.
    func canGetValueForKey(key: String) -> Bool { return class_getProperty(self.dynamicType, key) != nil }
    
    /// Returns `true` if the class has the property and it is not readonly.
    func canSetValueForKey(key: String) -> Bool {
        let property = class_getProperty(self.dynamicType, key)
        guard property != nil else { return false }
        guard let attributes = String.fromCString(property_getAttributes(property)) else { return false }
        return !attributes.containsString(",R")
    }
}