//
//  UserTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 09/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class UserTests: XCTestCase {
    
    var user: User = User(username: "", mailAddress: "")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatUserCanHaveName() {
        user.username = "pippo"
        XCTAssertEqual(user.username, "pippo", "the user should keep the name assigned")
    }
    
    func testThatUserCanHaveMailAddress() {
        user.mailAddress = "pippo"
        XCTAssertEqual(user.mailAddress, "pippo", "the user should keep the mail address assigned")
    }
}