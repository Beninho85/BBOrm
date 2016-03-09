//
//  BBManager.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 30/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

public class BBManager {
    
    public static var apiKey: String?
    
    public static var apiUrl: String?
    
    /* Set debug mode */
    public static var isDebug = false
    
    /* Object identifier default property */
    public static var objIdDefault = "id"
    
    /* Initialize all setup datas. Here: Api Key and apiUrl */
    public static func initialize(apiUrl:String,apiKey:String?){
        BBManager.apiUrl = apiUrl
        BBManager.apiKey = apiKey
    }
    
    public static func initialize(apiUrl:String){
        BBManager.apiUrl = apiUrl
    }
    
}