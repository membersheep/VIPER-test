//
//  MockLoginModule.swift
//  MORE
//
//  Created by Alessandro Maroso on 18/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation

class MockLoginModule: LoginModuleInterface {
    
    var saveUserDataCalled: Bool = false

    var updateViewCalled: Bool = false

    func saveUserData(username: String, mailAddress: String) {
        saveUserDataCalled = true
    }
    
    func updateView() {
        updateViewCalled = true
    }
}