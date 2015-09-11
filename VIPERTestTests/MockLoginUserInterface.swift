//
//  MockLoginUserInterface.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation

class MockLoginUserInterface: LoginUserInterface {
    
    var showInvalidCredentialsInsertedCalled: Bool = false
    
    var updateTextFieldsWithUsernameCalled: Bool = false
    
    var goToNextModuleCalled: Bool = false
    
    func showInvalidCredentialsError() {
        showInvalidCredentialsInsertedCalled = true
    }
    
    func updateTextFieldsWithUsername(username: String, andAddress mailAddress: String) {
        updateTextFieldsWithUsernameCalled = true
    }
    
    func prepareToGoToNextModule(completion: ((Bool) -> Void)?) {
        goToNextModuleCalled = true
    }
}