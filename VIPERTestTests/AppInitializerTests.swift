//
//  AppInitializerTests.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class AppInitializerTests: XCTestCase {
    
    var appInitializer: AppInitializer = AppInitializer()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test installRootViewControllerIntoWindow
    func testThatShowsALoginViewControllerWhenThereAreNoCredentials() {
        UserDefaultsStore.removeFromUserDefaults(key: UserDefaultsStore.usernameKey)
        UserDefaultsStore.removeFromUserDefaults(key: UserDefaultsStore.mailKey)
        
        let window = UIWindow()
        let navController = UINavigationController()
        window.rootViewController = navController
        
        appInitializer.installRootViewControllerIntoWindow(window: window)
        
        if let rootVC = window.rootViewController as? UINavigationController{
            if let loginVC = rootVC.viewControllers[0] as? UIViewController {
                XCTAssertNotNil(loginVC as? LoginViewController, "must be a login view controller")
            } else {
                XCTFail("first view controller must be a view controller")
            }
        } else {
            XCTFail("window must have a rootViewController that is a navigation controller")
        }
    }
    
    func testThatShowsAMainViewControllerWhenThereAreCredentials() {
        UserDefaultsStore.saveToUserDefaults(object: "pippo" as AnyObject, key: UserDefaultsStore.usernameKey)
        UserDefaultsStore.saveToUserDefaults(object: "pippo@pluto.com" as AnyObject, key: UserDefaultsStore.mailKey)
        
        let window = UIWindow()
        let navController = UINavigationController()
        window.rootViewController = navController
        
        appInitializer.installRootViewControllerIntoWindow(window: window)
        
        if let rootVC = window.rootViewController as? UINavigationController {
            if let mainVC = rootVC.viewControllers[0] as? UIViewController {
                XCTAssertNotNil(mainVC as? MainViewController, "must be a main view controller")
            } else {
                XCTFail("first view controller must be a view controller")
            }
        } else {
            XCTFail("window must have a rootViewController that is a navigation controller")
        }
    }
}
