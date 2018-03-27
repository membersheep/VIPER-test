//
//  LoginViewControllerTests.swift
//  MORE
//
//  Created by Alessandro Maroso on 16/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit
import XCTest
import VIPERTest

class LoginViewControllerTests: XCTestCase {
    
    var loginViewController: LoginViewController?
    
    var loginModule: MockLoginModule?
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        loginModule = MockLoginModule()
        loginViewController?.loginModule = loginModule
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Base tests
    
    func testThatLoginViewControllerExists() {
        XCTAssertNotNil(loginViewController, "a LoginViewController instance should be creatable from storyboard")
    }
    
    // MARK: viewDidLoad tests
    
    func testThatAfterViewDidLoadAScrollViewIsPresent() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.scrollView, "a scrollView instance should be present")
    }
    
    func testThatAfterViewDidLoadATitleViewIsPresent() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.titleView, "a titleView instance should be present")
    }
    
    func testThatAfterViewDidLoadATitleViewCenterConstraintIsPresent() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.titleViewCenterConstraint, "a titleViewCenterConstraint instance should be present")
    }
    
    func testThatAfterViewDidLoadAUsernameTextFieldIsPresent() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.usernameTextField, "a usernameTextField instance should be present")
    }
    
    func testThatAfterViewDidLoadAMailTextFieldIsPresent() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.mailTextField, "a mailTextField instance should be present")
    }
    
    func testThatAfterViewDidLoadASaveButtonIsPresent() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.saveButton, "a saveButton instance should be present")
    }
    
    func testThatAfterViewDidLoadTextFieldsHaveDelegate() {
        loginViewController?.view
        
        XCTAssertNotNil(loginViewController?.usernameTextField?.delegate, "username text field should have a delegate")
        XCTAssertNotNil(loginViewController?.mailTextField?.delegate, "mail text field should have a delegate")
    }
    
    func testThatAfterViewDidLoadALoginModuleUpdatesView() {
        loginViewController?.view
        
        if let loginModule = loginModule {
            XCTAssertTrue(loginModule.updateViewCalled, "the controller should have a module")
        } else {
            XCTFail("a LoginModule instance should be created")
        }
    }
    
    // MARK: viewWillAppear tests
    
    func testThatAfterViewWillAppear() {
        loginViewController?.view
        
        // TODO: Check for registration to notification center
    }
    
    func testThatAfterViewDidDisappear() {
        loginViewController?.view
        
        // TODO
    }
    
    func testThatAfterKeyboardWillShow() {
        loginViewController?.view
        
        // TODO
    }
    
    func testThatAfterKeyboardWillHide() {
        loginViewController?.view
        
        // TODO
    }
    
    func testThatAfterTouchesBegan() {
        loginViewController?.view
        
        // TODO
    }
    
    func testThatAfterTextFieldsShouldReturn() {
        loginViewController?.view
        loginViewController?.textFieldShouldReturn(textField: UITextField())
        
        if let loginViewController = loginViewController {
            if let usernameTextField = loginViewController.usernameTextField {
                XCTAssertFalse(usernameTextField.isFirstResponder, "shouldn't be first responder anymore")
            }
        }
        
        if let loginViewController = loginViewController {
            if let mailTextField = loginViewController.mailTextField {
                XCTAssertFalse(mailTextField.isFirstResponder, "shouldn't be first responder anymore")
            }
        }
        
    }
    
    func testThatAfterSaveButtonPressedModuleSavesData() {
        loginViewController?.view
        loginViewController?.saveButtonPressed(sender: loginViewController!)
        
        if let loginModule = loginModule {
            XCTAssertTrue(loginModule.saveUserDataCalled, "saveUserData should be called")
        } else {
            XCTFail("loginModule should be created")
        }
    }
    
    func testThatUpdateTextFieldsUpdatesTextFields() {
        // TODO: Implement
    }
    
    func testThatGoToNextModuleTriggersWireframe() {
        loginViewController?.view
        
        // TODO: Implement
    }
}
