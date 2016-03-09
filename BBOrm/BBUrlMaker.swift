//
//  BBUrlMaker.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 02/02/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

public class BBUrlMaker{
    
    public static func constructUrlFromBaseString(className: String,crudFunc: Functionality,objectId: String?) -> String{
        assert(BBManager.apiUrl != nil, "You must first initialize BBManager with : BBManager.initialize(\"https://yourapiurl.com\"). See \(gitHubLink) for more information")
        
        return BBUrlMaker.constructUrlFromBaseString(BBManager.apiUrl!, className: className, crudFunc: crudFunc, objectId: objectId)
    }
    
    /* Construct url string for API Request according to parameters:
        urlString: String -> Base String
        className: String -> the name of API Class
        crudFund: Functionality: create, read, update, delete
        objectId: Int? -> Object id to update. Mandatory for GET, UPDATE,DELETE
    */
    private static func constructUrlFromBaseString(urlString: String,className: String,crudFunc: Functionality,objectId: String?) -> String{
        
        // Base string with class name added
        var baseUrlString: String = urlString
        assert(baseUrlString.characters.last != nil, "You can't provide nil url string")
        if(baseUrlString.characters.last! == "/"){
            // If user specified / it's ok
            baseUrlString += className
        } else {
            // Else we add it for calls
            baseUrlString += "/" + className
        }
        
        // String generated for API Call
        let funcString: String = BBUrlMaker.stringFromFunc(crudFunc, objectId: objectId)
        
        // Merging both
        let stringToReturn:String = baseUrlString + funcString
        return stringToReturn
    }
    
    /* Return right API string according to Sails.js RESTFul API */
    private static func stringFromFunc(crudFunc: Functionality,objectId: String?) -> String{
        let objId: String
        if let objIdStr = objectId {
            objId = objIdStr
        } else {
            assert(!(crudFunc == .UPDATE || crudFunc == .DELETE || crudFunc == .GET), "You have to provide objectId for UPDATE, DELETE and GET function")
            objId = "-1"
        }
        
        // Adding CRUD function
        let functionality: String
        switch (crudFunc) {
        case .GET:
            functionality = BBAPIRoutes.getString + "/" + objId
            break;
        case .GETALL:
            functionality = BBAPIRoutes.getAllString
            break;
        case .CREATE:
            functionality = BBAPIRoutes.createString
            break;
        case .UPDATE:
            functionality = BBAPIRoutes.updateString + "/" + objId
            break;
        case .DELETE:
            functionality = BBAPIRoutes.deleteString + "/" + objId
            break;
        }
        
        // We remove duplicate slashes
        return functionality.stringByReplacingOccurrencesOfString("//", withString: "/")
    }
}