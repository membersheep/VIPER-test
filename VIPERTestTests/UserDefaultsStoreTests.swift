//
//  UserDefaultsStoreTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class UserDefaultsStoreTests: XCTestCase {
    
    let defaults = UserDefaults.standard
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadFromUserDefaults() {
        defaults.set("pippo", forKey: "pippo")
        defaults.synchronize()
        
        var result = UserDefaultsStore.loadFromUserDefaults(key: "pippo") as? String
        
        if let result = result {
            XCTAssertTrue(result == "pippo", "should be the same value saved")
        } else {
            XCTFail("should load a saved value for a key")
        }
        defaults.removeObject(forKey: "pippo")
       defaults.synchronize()
    }
    
    func testSaveToUserDefaults() {
        UserDefaultsStore.saveToUserDefaults(object: "pippo" as AnyObject, key: "pippo")
        
        let result = defaults.object(forKey: "pippo") as? String
        
        if let result = result {
            XCTAssertTrue(result == "pippo", "should be the same value saved")
        } else {
            XCTFail("should save a value for a key")
        }
        
        defaults.removeObject(forKey: "pippo")
        defaults.synchronize()
    }
    
    func testRemoveFromUserDefaults() {
        defaults.set("pippo", forKey: "pippo")
        defaults.synchronize()
        
        UserDefaultsStore.removeFromUserDefaults(key: "pippo")
        
        let result: AnyObject? = defaults.object(forKey: "pippo") as AnyObject
        
        XCTAssertNil(result, "should not find a value")
        
        defaults.removeObject(forKey: "pippo")
        defaults.synchronize()
    }
    
    func testRemoveAllEntries() {
        defaults.set("pippo", forKey: "pippo")
        defaults.set("pluto", forKey: "pluto")
        defaults.synchronize()
        
        UserDefaultsStore.removeAllEntries()
        
        let firstResult: AnyObject? = defaults.object(forKey: "pippo") as AnyObject
        let secondResult: AnyObject? = defaults.object(forKey: "pluto") as AnyObject
        
        XCTAssertNil(firstResult, "should not find a value")
        XCTAssertNil(secondResult, "should not find a value")
        
        defaults.removeObject(forKey: "pippo")
        defaults.removeObject(forKey: "pluto")
        defaults.synchronize()
    }
    
    func testSaveCredentials() {
        UserDefaultsStore.saveCredentials(credentials: ("pippo", "pluto"))
        
        let username = defaults.object(forKey: UserDefaultsStore.usernameKey) as? String
        let mail = defaults.object(forKey: UserDefaultsStore.mailKey) as? String
        
        if let username = username {
            XCTAssertTrue(username == "pippo", "should be the same value saved")
        } else {
            XCTFail("should save a value for a key")
        }
        
        if let mail = mail {
            XCTAssertTrue(mail == "pluto", "should be the same value saved")
        } else {
            XCTFail("should save a value for a key")
        }
        
        defaults.removeObject(forKey: UserDefaultsStore.usernameKey)
        defaults.removeObject(forKey: UserDefaultsStore.mailKey)
        
        defaults.synchronize()
    }
    
    func testLoadCredentials() {
        defaults.set("pippo", forKey: UserDefaultsStore.usernameKey)
        defaults.set("pluto", forKey: UserDefaultsStore.mailKey)
        defaults.synchronize()
        
        let result = UserDefaultsStore.loadCredentials()
        
        if let result = result {
            XCTAssertTrue(result.username == "pippo", "should be the same value saved")
            XCTAssertTrue(result.mailAddress == "pluto", "should be the same value saved")
        } else {
            XCTFail("should load a saved value for a key")
        }
        defaults.removeObject(forKey: UserDefaultsStore.usernameKey)
        defaults.removeObject(forKey: UserDefaultsStore.mailKey)
        defaults.synchronize()
    }
}
