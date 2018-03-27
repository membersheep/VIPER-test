//
//  LoginInteractorTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 18/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class LoginInteractorTests: XCTestCase {
    
    var interactor: LoginInteractor = LoginInteractor()
    
    var loginDataManager: FakeLoginDataManager = FakeLoginDataManager()
    
    var loginViewInteractorDelegate: FakeLoginInteractorDelegate = FakeLoginInteractorDelegate()

    override func setUp() {
        super.setUp()
        
        // Reset delegate and data manager
        loginDataManager = FakeLoginDataManager()
        interactor.loginDataManager = loginDataManager
        loginViewInteractorDelegate = FakeLoginInteractorDelegate()
        interactor.delegate = loginViewInteractorDelegate
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatGetUsernameReturnsUsernameIfTheresAUser() {
        loginDataManager.setCurrentUser(user: User(username: "pippo", mailAddress: "pippo@pluto.com"))
        
        XCTAssertEqual(interactor.getUsername(), "pippo", "should return the username set in the data manager")
    }
    
    func testThatGetUsernameReturnsEmptyStringIfThereIsntAUser() {
        loginDataManager.resetCurrentUser()
        
        XCTAssertEqual(interactor.getUsername(), "", "should return empty string if there's no user in the data manager")
    }
    
    func testThatGetMailaddressReturnsMailaddressIfTheresAUser() {
        loginDataManager.setCurrentUser(user: User(username: "pippo", mailAddress: "pippo@pluto.com"))
        
        XCTAssertEqual(interactor.getMailAddress(), "pippo@pluto.com", "should return the mail address set in the data manager")
    }
    
    func testThatGetMailaddressReturnsEmptyStringIfThereIsntAUser() {
        XCTAssertEqual(interactor.getMailAddress(), "", "should return empty string if there's no user in the data manager")
    }
    
    func testThatSetUserSetsUserForValidCredentials() {
        interactor.setUser(username: "pippo", mailAddress: "pippo@pluto.com")
        
        XCTAssert(loginDataManager.getCurrentUser() != nil, "should be able to set a user in data manager ")
    }
    
    func testThatSetUserDoesntSetUserForInvalidCredentials() {
        interactor.setUser(username: "", mailAddress: "pippo@pluto.com")
        
        XCTAssert(loginDataManager.getCurrentUser() == nil, "shouldn't be able to set a user in data manager with invalid data")
        
        interactor.setUser(username: "pippo", mailAddress: "pippopluto.com")
        
        XCTAssert(loginDataManager.getCurrentUser() == nil, "shouldn't be able to set a user in data manager with invalid data")
        
        interactor.setUser(username: "pippo", mailAddress: "pippo@pluto")
        
        XCTAssert(loginDataManager.getCurrentUser() == nil, "shouldn't be able to set a user in data manager with invalid data")
        
        interactor.setUser(username: "pippo", mailAddress: "")
        
        XCTAssert(loginDataManager.getCurrentUser() == nil, "shouldn't be able to set a user in data manager with invalid data")
    }
    
    func testThatSetUserCallsDelegateForValidCredentials() {
        interactor.setUser(username: "pippo", mailAddress: "pippo@pluto.com")
        
        XCTAssertTrue(loginViewInteractorDelegate.validCredentialsInsertedCalled, "should be called the right delegate when the user sets valid credentials")
        XCTAssertFalse(loginViewInteractorDelegate.invalidCredentialsInsertedCalled, "should be called the right delegate when the user sets valid credentials")
    }
    
    func testThatSetUserCallsDelegateForInvalidCredentials() {
        interactor.setUser(username: "pippo", mailAddress: "pippopluto.com")
        
        XCTAssertFalse(loginViewInteractorDelegate.validCredentialsInsertedCalled, "should be called the right delegate when the user sets valid credentials")
        XCTAssertTrue(loginViewInteractorDelegate.invalidCredentialsInsertedCalled, "should be called the right delegate when the user sets valid credentials")
    }
}
