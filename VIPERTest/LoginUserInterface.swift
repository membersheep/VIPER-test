//
//  LoginUserInterface.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation

// MARK: LoginUserInterface Protocol Definition

protocol LoginUserInterface{
    func showInvalidCredentialsError()
    func updateTextFieldsWithUsername(username: String, andAddress mailAddress: String)
    func prepareToGoToNextModule(completion: ((Bool) -> Void)?)
}