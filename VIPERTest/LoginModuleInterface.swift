//
//  LoginModuleInterface.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation

// MARK: LoginModuleInterface Protocol Definition

protocol LoginModuleInterface{
    
    /// Tries to save user data
    ///
    /// :param: username The username string
    /// :param: mailAddress The mail address string
    func saveUserData(username: String, mailAddress: String)
    
    /// Updates user interface with right data
    func updateView()
}