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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadFromUserDefaults() {
        defaults.setObject("pippo", forKey: "pippo")
        defaults.synchronize()
        
        var result = UserDefaultsStore.loadFromUserDefaults("pippo") as? String
        
        if let result = result {
            XCTAssertTrue(result == "pippo", "should be the same value saved")
        } else {
            XCTFail("should load a saved value for a key")
        }
       defaults.removeObjectForKey("pippo")
       defaults.synchronize()
    }
    
    func testSaveToUserDefaults() {
        UserDefaultsStore.saveToUserDefaults("pippo", key: "pippo")
        
        let result = defaults.objectForKey("pippo") as? String
        
        if let result = result {
            XCTAssertTrue(result == "pippo", "should be the same value saved")
        } else {
            XCTFail("should save a value for a key")
        }
        
        defaults.removeObjectForKey("pippo")
        defaults.synchronize()
    }
    
    func testRemoveFromUserDefaults() {
        defaults.setObject("pippo", forKey: "pippo")
        defaults.synchronize()
        
        UserDefaultsStore.removeFromUserDefaults("pippo")
        
        let result: AnyObject? = defaults.objectForKey("pippo")
        
        XCTAssertNil(result, "should not find a value")
        
        defaults.removeObjectForKey("pippo")
        defaults.synchronize()
    }
    
    func testRemoveAllEntries() {
        defaults.setObject("pippo", forKey: "pippo")
        defaults.setObject("pluto", forKey: "pluto")
        defaults.synchronize()
        
        UserDefaultsStore.removeAllEntries()
        
        let firstResult: AnyObject? = defaults.objectForKey("pippo")
        let secondResult: AnyObject? = defaults.objectForKey("pluto")
        
        XCTAssertNil(firstResult, "should not find a value")
        XCTAssertNil(secondResult, "should not find a value")
        
        defaults.removeObjectForKey("pippo")
        defaults.removeObjectForKey("pluto")
        defaults.synchronize()
    }
    
    func testSaveCredentials() {
        UserDefaultsStore.saveCredentials(("pippo", "pluto"))
        
        let username = defaults.objectForKey(UserDefaultsStore.usernameKey) as? String
        let mail = defaults.objectForKey(UserDefaultsStore.mailKey) as? String
        
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
        
        defaults.removeObjectForKey(UserDefaultsStore.usernameKey)
        defaults.removeObjectForKey(UserDefaultsStore.mailKey)
        
        defaults.synchronize()
    }
    
    func testLoadCredentials() {
        defaults.setObject("pippo", forKey: UserDefaultsStore.usernameKey)
        defaults.setObject("pluto", forKey: UserDefaultsStore.mailKey)
        defaults.synchronize()
        
        let result = UserDefaultsStore.loadCredentials()
        
        if let result = result {
            XCTAssertTrue(result.username == "pippo", "should be the same value saved")
            XCTAssertTrue(result.mailAddress == "pluto", "should be the same value saved")
        } else {
            XCTFail("should load a saved value for a key")
        }
        defaults.removeObjectForKey(UserDefaultsStore.usernameKey)
        defaults.removeObjectForKey(UserDefaultsStore.mailKey)
        defaults.synchronize()
    }
}