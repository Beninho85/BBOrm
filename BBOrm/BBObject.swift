//
//  BBObject.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 29/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

public class BBObject: NSObject{
    
    public var id: String?
    
    public required override init(){
        
    }
    
    // MARK: Introspection features
    
    public func inspectProperties() -> [BBProperty] {
        
        // We create a mirror of the object
        let objectReflect = Mirror(reflecting: self)
        
        var properties: [BBProperty] = []
        
        // Introspection of properties
        for child in objectReflect.children {
            //print("Child: \(child)")
            if let lab = child.label {
                if(lab.characters.count > 0){
                    let index = lab.endIndex.predecessor()
                    let lastChar = lab[index]
                    if (lastChar == "_") {
                        // It's a private or unnamed property, we ignore it
                    } else {
                        if(frameworkDebug){
                            // We have the key of the property
                            print("Label: \(lab)")
                            // The value
                            print("Value: \(child.value)")
                        }
                        
                        let property: BBProperty = BBProperty(key: lab, value: child.value, type: BBType(rawValue: "String")!)
                        
                        properties.append(property)
                    }
                }
            } else {
                // Unnamed property, we ignore it
            }
        }
        
        return properties
    }
    
    // MARK: About classname and identifier
    
    /* Return the class name. The real class name is used. You can override it to get your own Table name */
    public func getClassName() -> String {
        return String(self.dynamicType)
    }
    
    /* Return the object property name. You can override it to get your own object identifier property */
    public func getObjectIdString() -> String{
        return BBManager.objIdDefault
    }
    
    /* Get value of object Id. can be nil if object is not fetched yet. 
        IMPORTANT: You have to check if getObjectIdString is a real property of your object and if your objectId type can be cast in String
    */
    public func getIdValue() -> String? {
        return self.valueForKey(self.getObjectIdString()) as? String
    }
    
    // MARK: JSON/Dic Conversion
    
    /* Return dictionnary of parameters with a value */
    public func getDicParameters() -> [String: AnyObject]? {
        let properties = self.inspectProperties()
        
        var parameters: [String: AnyObject] = [String: AnyObject]()
        
        for property in properties {
            if(frameworkDebug){
                print("Key: \(property.key)")
                print("Type: \(property.type)")
            }
            if let val = self.valueForKey(property.key) as? String  {
                // Property has a value, we can include it in dictionary
                    parameters[property.key] = val
                if(frameworkDebug){
                    print("Value: \(val)")
                }
            } else {
                if(frameworkDebug){
                    print("Value: nil")
                }
            }
        }
        
        return parameters
    }
    
    public func fetchWithDictionary(dic: NSDictionary){
        for (key, value) in dic {
            if(self.canSetValueForKey(key as! String)){
                self.setValue(value, forKey: key as! String)
            }
        }
    }
    
    // MARK: Performing requests
    
    public func save(compl: (success: Bool) ->()){
        BBAPI.saveObject(self) { (success) -> () in
            compl(success: success)
        }
    }
    
    public func destroy(compl: (success: Bool) ->()){
        BBAPI.deleteObject(self) { (success) -> () in
            compl(success: success)
        }
    }
    
    public func refresh(compl: (success: Bool) ->()){
        BBAPI.refreshObject(self) { (success, dic) -> () in
            if(success){
                self.fetchWithDictionary(dic)
                compl(success: false)
            } else {
                compl(success: false)
            }
        }
    }
    
    public static func getAll(obj: BBObject,compl: (success: Bool, objects: [BBObject]) ->()){
        BBAPI.getAllObjects(obj) { (success, objects) -> () in
            if(success){
                var objArray:[BBObject] = []
                for jsonDic in objects {
                    // We init object with subclass type, not BBObject
                    let subclass = obj.dynamicType
                    let object = subclass.init()
                    object.fetchWithDictionary(jsonDic)
                    objArray.append(object)
                }
                compl(success: true, objects: objArray)
            } else {
                compl(success: false, objects: [])
            }
        }
        
    }
    
    public func request() -> BBRequest{
        return BBRequest.init(object: self)
    }
    
}