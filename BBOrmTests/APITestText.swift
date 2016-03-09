//
//  TestSavableObject.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 29/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

import BBOrm

public class APITestText : BBObject {
    
    var key: String?
    var lang: String?
    var value: String?
    
    public required init() {
        
    }
    
    public override func getClassName() -> String {
        return "Text"
    }
}