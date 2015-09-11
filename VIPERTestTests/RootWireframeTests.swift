//
//  RootWireframeTests.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class RootWireframeTests: XCTestCase {
    
    var rootWireframe: RootWireframe?
    
    override func setUp() {
        super.setUp()
        rootWireframe = RootWireframe()
        rootWireframe?.window = UIWindow()
        rootWireframe?.window?.rootViewController = UINavigationController();
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShowRootViewController() {
        let controller = UIViewController()
        
        rootWireframe?.showRootViewController(controller)
        
        if let window = rootWireframe?.window {
            if let rootVC = window.rootViewController as? UINavigationController {
                if let fisrtVC = rootVC.viewControllers[0] as? UIViewController{
                    XCTAssertEqual(fisrtVC, controller, "rootViewController should be the one I set")
                } else {
                    XCTFail("the first element of the viewcontrollers array must be a UIViewController")
                }
            } else {
                XCTFail("window's root view controller must be a navigation controller")
            }
        } else {
            XCTFail("root wireframe must have a window")
        }
        
    }
}