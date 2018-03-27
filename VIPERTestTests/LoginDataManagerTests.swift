//
//  LoginDataManagerTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 19/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

// TODO: Avoid using the userdefaults store to setup the tests, it's being tested too!

class LoginDataManagerTests: XCTestCase {
    
    var dataManager: LoginDataManager = LoginDataManager()
    
    override func setUp() {
        super.setUp()
        UserDefaultsStore.removeAllEntries()
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaultsStore.removeAllEntries()
    }
    
    func testThatGetCurrentUserReturnsNilIfTheresNoUserSavedInUserDefaults() {
        UserDefaultsStore.removeAllEntries()
        
        XCTAssert(dataManager.getCurrentUser() == nil, "should return nil when there's no user saved")
    }
    
    func testThatGetCurrentUserReturnsAUserIfTheresAUserSavedInUserDefaults() {
        UserDefaultsStore.saveCredentials(credentials: ("pippo", "pippo@pluto.com"))
        
        XCTAssert(dataManager.getCurrentUser() != nil, "should return nil when there's no user saved")
    }
    
    func testThatSetCurrentUserSavesCurrentUserInUserDefaults() {
        dataManager.setCurrentUser(user: User(username: "pippo", mailAddress: "pippo@pluto.com"))
        
        XCTAssert(UserDefaultsStore.loadCredentials() != nil, "should save credentials when I just saved a user")
        
    }
    
}
