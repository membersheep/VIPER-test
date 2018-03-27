//
//  AppDelegateTests.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class AppDelegateTests: XCTestCase {
    
    var appDelegate: AppDelegate = AppDelegate();
    var window: UIWindow? = UIWindow()
    
    override func setUp() {
        super.setUp()
        appDelegate.window = window
    }
    
    override func tearDown() {
        super.tearDown()
        window = nil
    }
    
    // MARK: Test after init
    
    func testThatHasInitializerAfterInit() {
        XCTAssertNotNil(appDelegate.appInitializer, "should have a appInitializer after being initialized")
    }
    
    // MARK: Test after application launch
    
    func testWindowIsKeyAfterApplicationLaunch() {
        let mainAppDelegate = UIApplication.shared.delegate
        
        if let mainAppDelegate = mainAppDelegate {
            if let window = mainAppDelegate.window {
                if let window = window {
                    XCTAssertTrue(window.isKeyWindow)
                }
                else {
                    XCTFail("app delegate window should not be nil")
                }
            } else {
                XCTFail("app delegate window should not be nil")
            }
        }
        else {
            XCTFail("shared application should have a delegate")
        }
    }
    
    func testThatDidFinishLaunchingWithOptionsReturnsTrue() {
        XCTAssertTrue(appDelegate.application(application: UIApplication.shared, didFinishLaunchingWithOptions: nil), "should return true from didFinishLaunchingWithOptions")
    }
}

