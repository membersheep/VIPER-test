//
//  LoginPresenter.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation

class LoginPresenter: LoginInteractorDelegate, LoginModuleInterface {
    
    var interactor: LoginInteractor?
    
    var wireframe: LoginWireframe?
    
    var interface: LoginUserInterface?
    
    init() {
    }
    
    func saveUserData(username: String, mailAddress: String) {
        interactor?.setUser(username: username, mailAddress: mailAddress)
    }
    
    func updateView() {
        if let user = interactor?.currentUser {
            interface?.updateTextFieldsWithUsername(username: user.username, andAddress: user.mailAddress)
        } else {
            interface?.updateTextFieldsWithUsername(username: "", andAddress: "")
        }
    }
    
    // MARK: Interactor delegate methods
    
    func invalidCredentialsInserted() {
        interface?.showInvalidCredentialsError()
    }
    
    func validCredentialsInserted() {
        interface?.prepareToGoToNextModule(completion: {completion in
            self.wireframe?.goToMainModule()
        })
    }
}
