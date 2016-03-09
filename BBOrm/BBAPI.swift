//
//  BBAPI.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 02/02/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

import Alamofire

public class BBAPI {
    
    public static func saveObject(object: BBObject,compl: (success: Bool) ->() ){
        
        if let _ = object.getIdValue() {
            // We have an id, we have to update object in database
            BBAPI.updateObject(object, compl: { (success) -> () in
                compl(success: success)
            })
        } else {
            // We have no id, we have to insert it in database
            BBAPI.insertObject(object, compl: { (success) -> () in
                compl(success: success)
            })
        }
    }
    
    public static func insertObject(object: BBObject,compl: (success: Bool) ->() ){
        let urlString: String = BBUrlMaker.constructUrlFromBaseString(object.getClassName(), crudFunc: .CREATE, objectId: object.getIdValue())
        if(BBManager.isDebug){
            print("Insert function for object \(object.getClassName())")
            print("POST Request from url: \(urlString) \n with parameters: \(object.getDicParameters())")
        }
        Alamofire.request(.POST, urlString, parameters: object.getDicParameters())
            .responseJSON { response in
                if(response.result.isSuccess){
                    // TODO: Refresh object identifier
                    if(BBManager.isDebug){
                        print("Object saved")
                    }
                } else {
                    if(BBManager.isDebug){
                        print("Object not saved")
                    }
                }
                compl(success: response.result.isSuccess)
            }
    }
    
    public static func updateObject(object: BBObject,compl: (success: Bool) ->() ){
        let urlString: String = BBUrlMaker.constructUrlFromBaseString(object.getClassName(), crudFunc: .UPDATE, objectId: object.getIdValue())
        if(BBManager.isDebug){
            print("Update function for object \(object.getClassName()) with id : \(object.getIdValue())")
            print("PUT Request from url: \(urlString) \n with parameters: \(object.getDicParameters())")
        }
        Alamofire.request(.PUT, urlString, parameters: object.getDicParameters())
            .responseJSON { response in
                if(response.result.isSuccess){
                    if(BBManager.isDebug){
                        print("Object updated")
                    }
                } else {
                    if(BBManager.isDebug){
                        print("Object not updated")
                    }
                }
                compl(success: response.result.isSuccess)
        }
    }
    
    public static func deleteObject(object: BBObject,compl: (success: Bool) ->() ){
        let urlString: String = BBUrlMaker.constructUrlFromBaseString(object.getClassName(), crudFunc: .DELETE, objectId: object.getIdValue())
        if(BBManager.isDebug){
            print("Delete function for object \(object.getClassName()) with id : \(object.getIdValue())")
            print("DELETE Request from url: \(urlString) \n with parameters: \(object.getDicParameters())")
        }
        Alamofire.request(.DELETE, urlString, parameters: object.getDicParameters())
            .responseJSON { response in
                if(response.result.isSuccess){
                    if(BBManager.isDebug){
                        print("Object deleted")
                    }
                } else {
                    if(BBManager.isDebug){
                        print("Object not deleted")
                    }
                }
                compl(success: response.result.isSuccess)
        }
    }
    
    public static func getAllObjects(object: BBObject, compl: (success: Bool, objects: [NSDictionary]) ->()){
        let urlString: String = BBUrlMaker.constructUrlFromBaseString(object.getClassName(), crudFunc: .GETALL, objectId: object.getIdValue())
        if(BBManager.isDebug){
            print("Get all function for object \(object.getClassName())")
            print("GET Request from url: \(urlString) \n with no parameters")
        }
        Alamofire.request(.GET, urlString, parameters: nil)
            .responseJSON { response in
                if(response.result.isSuccess){
                    if let JSON = response.result.value {
                        if(BBManager.isDebug){
                            print("Objects retrieved")
                            print("JSON: \(JSON)")
                        }
                        let array:[NSDictionary] = JSON as! [NSDictionary]
                        compl(success: true, objects: array)
                        
                    } else {
                        if(BBManager.isDebug){
                            print("Objects retrieved but no JSON Datas")
                        }
                        compl(success: true, objects: [])
                    }
                } else {
                    if(BBManager.isDebug){
                        print("Objects not retrieved")
                    }
                    compl(success: false, objects: [])
                }
        }
    }
    
    public static func refreshObject(object: BBObject,compl: (success: Bool, dic: NSDictionary) ->() ){
        let urlString: String = BBUrlMaker.constructUrlFromBaseString(object.getClassName(), crudFunc: .GET, objectId: object.getIdValue())
        if(BBManager.isDebug){
            print("Get for object \(object.getClassName()) with id : \(object.getIdValue())")
            print("GET Request from url: \(urlString) \n with no parameters")
        }
        Alamofire.request(.GET, urlString, parameters: nil)
            .responseJSON { response in
                if(response.result.isSuccess){
                    if let JSON = response.result.value {
                        if(BBManager.isDebug){
                            print("Object retrieved")
                            print("JSON: \(JSON)")
                        }
                        let dict:NSDictionary = JSON as! NSDictionary
                        compl(success: true, dic: dict)
                        
                    } else {
                        if(BBManager.isDebug){
                            print("Object retrieved but no JSON Datas")
                        }
                        compl(success: false, dic: [:])
                    }
                } else {
                    if(BBManager.isDebug){
                        print("Object not retrieved")
                    }
                    compl(success: false, dic: [:])
                }
        }
    }
    
}