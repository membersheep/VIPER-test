//
//  FakeLoginViewInteractorDelegate.swift
//  MORE
//
//  Created by Alessandro Maroso on 19/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation

class FakeLoginInteractorDelegate: LoginInteractorDelegate {

    var invalidCredentialsInsertedCalled: Bool = false
    
    var validCredentialsInsertedCalled: Bool = false
    
    func invalidCredentialsInserted() {
        invalidCredentialsInsertedCalled = true
    }
    
    func validCredentialsInserted() {
        validCredentialsInsertedCalled = true
    }
}