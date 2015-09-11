//
//  User.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 10/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation

struct User {
    
    /// The username of the user
    var username: String
    
    /// The mail address for the user
    var mailAddress: String
    
    init(username: String, mailAddress: String) {
        self.username = username
        self.mailAddress = mailAddress
    }
}