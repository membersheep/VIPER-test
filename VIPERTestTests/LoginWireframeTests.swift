//
//  LoginWireframeTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

// TODO: Avoid using the userdefaults store to setup the tests, it's being tested too!

class LoginWireframeTests: XCTestCase {
    
    var loginWireframe: LoginWireframe = LoginWireframe()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatShowLoginModuleShowsLoginViewController() {
        let rootWireframe = MockRootWireframe()
        loginWireframe.rootWireframe = rootWireframe
        
        loginWireframe.showLoginModuleAsRoot()
        
        XCTAssertEqual(rootWireframe.viewControllerShown!, loginWireframe.loginViewController!, "should show login view controller")
    }
    
}
