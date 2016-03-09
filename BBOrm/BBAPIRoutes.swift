//
//  BBApiRoutes.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 07/03/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation


public class BBAPIRoutes {
    
    public static var getString: String = "/"
    public static var getAllString: String = "/"
    public static var createString: String = "/create"
    public static var updateString: String = "/update"
    public static var deleteString: String = "/destroy"
    
    /* Return right string from specified functionality of CRUD */
    public static func routeFromFunctionality(functionality: Functionality) -> String {
        switch (functionality) {
        case .GET:
            return getString
        case .GETALL:
            return getAllString
        case .CREATE:
            return createString
        case .UPDATE:
            return updateString
        case .DELETE:
            return deleteString
        }
    }
    
    /* To provide your own API Routes for custom API */
    public static func setRoutes(getString: String,getAllString: String,createString: String,updateString: String,deleteString: String){
        BBAPIRoutes.getString = getString
        BBAPIRoutes.getAllString = getAllString
        BBAPIRoutes.createString = createString
        BBAPIRoutes.updateString = updateString
        BBAPIRoutes.deleteString = deleteString
    }
}