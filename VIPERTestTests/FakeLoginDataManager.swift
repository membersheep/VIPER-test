//
//  FakeLoginDataManager.swift
//  MORE
//
//  Created by Alessandro Maroso on 19/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation

class FakeLoginDataManager: LoginDataManager {
    var currentUser: User?
    
    override func getCurrentUser() -> User? {
        return currentUser
    }
    
    override func setCurrentUser(user: User) -> Bool{
        currentUser = user
        return true;
    }
    
    func resetCurrentUser() {
        currentUser = nil
    }
}