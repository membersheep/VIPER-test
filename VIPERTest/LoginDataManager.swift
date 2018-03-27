//
//  LoginDataManager.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation

/// Converts the values returned by the defaults store into standard PONSO model objects, and passes those back to the business logic layer
class LoginDataManager {
    
    /// Returns the current saved user from the lower level or nil if there isn't one
    ///
    /// :returns: the current saved user or nil
    func getCurrentUser() -> User? {
        if let credentials = UserDefaultsStore.loadCredentials() {
            let user = User(username: credentials.username, mailAddress: credentials.mailAddress)
            return user
        } else {
            return nil
        }
    }
    
    /// Saves the argument as saved user in the lower level
    ///
    /// :param: user the user struct to save
    /// :returns: true if the User was successfully saved
    func setCurrentUser(user: User) -> Bool{
        return UserDefaultsStore.saveCredentials(credentials: (user.username, user.mailAddress))
    }
    
}
