//
//  LoginInteractor.swift
//  
//
//  Created by Alessandro Maroso on 11/09/15.
//
//

import Foundation
import UIKit

/// Contains the business logic of the login page
class LoginInteractor {
    
    var loginDataManager: LoginDataManager = LoginDataManager()
    
    var currentUser: User?
    
    var delegate: LoginInteractorDelegate?
    
    init() {
        self.currentUser = loginDataManager.getCurrentUser()
    }
    
    /// Gets the username or empty string if there is no user
    ///
    /// :returns: the username or an empty string
    func getUsername() -> String {
        updateCurrentUser()
        if let username = currentUser?.username {
            return username
        } else {
            // TODO: Do we have to treat this situation ad an error?
            return ""
        }
    }
    
    /// Gets the mail address or empty string if there is no user
    ///
    /// :returns: the mail address or an empty string
    func getMailAddress() -> String {
        updateCurrentUser()
        if let mailAddress = currentUser?.mailAddress {
            return mailAddress
        } else {
            return ""
        }
    }
    
    /// Tries to set the username and the mail address, verifying their validity
    ///
    func setUser(username: String, mailAddress: String) {
        if (isValidUsername(testStr: username) && isValidEmail(testStr: mailAddress)) {
            currentUser = User(username: username, mailAddress: mailAddress)
            loginDataManager.setCurrentUser(user: currentUser!)
            delegate?.validCredentialsInserted()
        } else {
            delegate?.invalidCredentialsInserted()
        }
    }
    
    // MARK: Private methods (the actual interactor logic)
    
    private func isValidUsername(testStr:String) -> Bool {
        return !testStr.isEmpty
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    private func updateCurrentUser() {
        currentUser = loginDataManager.getCurrentUser()
    }
}

// MARK: LoginViewInteractorDelegate Protocol Definition

protocol LoginInteractorDelegate {
    func invalidCredentialsInserted()
    func validCredentialsInserted()
}
