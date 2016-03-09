//
//  BBProperty.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 29/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

public class BBProperty {
    
    /* The key of object property */
    public let key: String
    
    /* The type of data of the property */
    public let type: BBType
    
    /* The value of the property */
    public var value: Any?
    
    public init(key: String, value: Any,type: BBType){
        self.key = key
        self.type = type
        self.value = value
    }
    
}