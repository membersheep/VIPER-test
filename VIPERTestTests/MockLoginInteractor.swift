//
//  MockLoginInteractor.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation

class MockLoginInteractor: LoginInteractor {
    
    var username: String = ""
    var mail: String = ""
    
    override func setUser(username: String, mailAddress: String) {
        self.username = username
        self.mail = mailAddress
    }
}