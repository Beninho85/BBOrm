//
//  BBRequest.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 08/03/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation


public class BBRequest {
    
    // Object of request
    private var object: BBObject
    
    // if Limit = nil, no limit
    public var limit:Int?
    
    // Where key1 comp value
    
    // Orderby
    
    public init(object: BBObject){
        self.object = object
    }
    
    public func getAll(compl: (success: Bool, objects: [BBObject]) ->()){
        BBObject.getAll(self.object,compl: { (success, objects) -> () in
            compl(success: success, objects: objects)
        })
    }
}