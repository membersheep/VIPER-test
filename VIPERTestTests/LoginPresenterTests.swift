//
//  LoginPresenterTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class LoginPresenterTests: XCTestCase {
    
    var presenter: LoginPresenter = LoginPresenter()
    
    var interactor: MockLoginInteractor = MockLoginInteractor()
    
    var interface: MockLoginUserInterface = MockLoginUserInterface()
    
    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        presenter.interface = interface
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatSaveUserDataSavesInInteractor() {
        presenter.saveUserData(username: "pippo", mailAddress: "pluto")
        
        XCTAssertEqual("pippo", interactor.username, "should save in interactor")
        XCTAssertEqual("pluto", interactor.mail, "should save in interactor")
    }
    
    func testThatUpdateViewUpdatesInterface() {
        presenter.updateView()
        
        XCTAssertTrue(interface.updateTextFieldsWithUsernameCalled, "should call updateTextFieldsWithUsernameCalled")
    }
    
    func testInvalidCredentialsInsertedCallsDelegate() {
        presenter.invalidCredentialsInserted()
        
        XCTAssertTrue(interface.showInvalidCredentialsInsertedCalled, "should call showInvalidCredentialsInsertedCalled")
    }
    
    func testValidCredentialsInsertedCallsDelegate() {
        presenter.validCredentialsInserted()
        
        XCTAssertTrue(interface.goToNextModuleCalled, "should call goToNextModule")
    }
}
