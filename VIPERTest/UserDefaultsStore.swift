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
        let defaults = UserDefaults.standard
        let object: AnyObject? = defaults.object(forKey: key) as AnyObject
        return object
    }
    
    static func saveToUserDefaults(object:AnyObject, key: String) -> Bool{
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        return defaults.synchronize()
    }
    
    static func removeFromUserDefaults(key: String) -> Bool{
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        return defaults.synchronize()
    }
    
    static func removeAllEntries() -> Bool{
        let defaults = UserDefaults.standard
        for key in defaults.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        return defaults.synchronize()
    }
    
    // MARK: Public methods, application specific
    
    /// Saves a credentials tuple
    ///
    /// :returns: The result of the operation (successfull or unsuccessfull)
    static func saveCredentials(credentials: CredentialsTuple) -> Bool{
        UserDefaultsStore.saveToUserDefaults(object: credentials.username as AnyObject, key: UserDefaultsStore.usernameKey)
        return UserDefaultsStore.saveToUserDefaults(object: credentials.mailAddress as AnyObject, key: UserDefaultsStore.mailKey)
    }
    
    /// :returns: The username and password as a credentials tuple or nil if they aren't there
    static func loadCredentials() -> CredentialsTuple? {
        let username: String? = UserDefaultsStore.loadFromUserDefaults(key: UserDefaultsStore.usernameKey) as? String
        let mailAddress: String? = UserDefaultsStore.loadFromUserDefaults(key: UserDefaultsStore.mailKey) as? String
        if let username = username, let mailAddress = mailAddress {
            return (username, mailAddress)
        } else {
            return nil
        }
    }
}
