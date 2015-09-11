//
//  UserDefaultsStore.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 10/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation

typealias CredentialsTuple = (username: String, mailAddress: String)

/// Handles the loading/saving process from/to userdefaults of user data, and ideally the domain logic
class UserDefaultsStore {
    
    // MARK: Constants
    
    static let usernameKey = "username"
    
    static let mailKey = "mail"
    
    // MARK: User Defaults methods. generic user defaults wrapper
    
    static func loadFromUserDefaults(key: String) -> (AnyObject?){
        let defaults = NSUserDefaults.standardUserDefaults()
        let object: AnyObject? = defaults.objectForKey(key)
        return object
    }
    
    static func saveToUserDefaults(object:AnyObject, key: String) -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(object, forKey: key)
        return defaults.synchronize()
    }
    
    static func removeFromUserDefaults(key: String) -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(key)
        return defaults.synchronize()
    }
    
    static func removeAllEntries() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        for key in defaults.dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key.description)
        }
        return defaults.synchronize()
    }
    
    // MARK: Public methods, application specific
    
    /// Saves a credentials tuple
    ///
    /// :returns: The result of the operation (successfull or unsuccessfull)
    static func saveCredentials(credentials: CredentialsTuple) -> Bool{
        UserDefaultsStore.saveToUserDefaults(credentials.username, key: UserDefaultsStore.usernameKey)
        return UserDefaultsStore.saveToUserDefaults(credentials.mailAddress, key: UserDefaultsStore.mailKey)
    }
    
    /// :returns: The username and password as a credentials tuple or nil if they aren't there
    static func loadCredentials() -> CredentialsTuple? {
        let username: String? = UserDefaultsStore.loadFromUserDefaults(UserDefaultsStore.usernameKey) as? String
        let mailAddress: String? = UserDefaultsStore.loadFromUserDefaults(UserDefaultsStore.mailKey) as? String
        if let username = username, let mailAddress = mailAddress {
            return (username, mailAddress)
        } else {
            return nil
        }
    }
}