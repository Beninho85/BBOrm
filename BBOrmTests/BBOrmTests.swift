//
//  BBOrmTests.swift
//  BBOrmTests
//
//  Created by Benjamin Bourasseau on 08/03/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import XCTest
@testable import BBOrm
import Alamofire

class BBOrmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.setupManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func setupManager(){
        BBManager.initialize(frameworkTestUrl, apiKey: nil)
        BBManager.isDebug = true
    }
    
    
    func testRouteUrl(){
        let urlString = BBUrlMaker.constructUrlFromBaseString("Test", crudFunc: .CREATE, objectId: nil)
        
        print(urlString)
        
        let regex = try! NSRegularExpression(pattern: "https?://(?:www\\.)?\\S+(?:/|\\b)", options: .CaseInsensitive)
        XCTAssert(regex.numberOfMatchesInString(urlString, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, urlString.characters.count)) == 1)
    }
    
    func testObjectSave() {
//        
//        let _ = expectationWithDescription("Saving object test")
//        
//        APITestText().request().getAll { (success, objects) -> () in
//            if(success && objects.count > 0){
//                let apitest:APITestText = objects[0] as! APITestText
//                apitest.value = "MODIFIEEEEEEEEE"
//                apitest.save({ (success) -> () in
//                    if(success){
//                        print("Objet modifié")
//                    } else {
//                        print("Objet  pas modifié")
//                    }
//                })
//            }
//        }
//        self.waitForExpectationsWithTimeout(5) { error in
//            
//            XCTAssert(true)
//        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
