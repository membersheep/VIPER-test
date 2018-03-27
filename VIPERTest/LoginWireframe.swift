//
//  LoginWireframe.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation
import UIKit

let LoginViewControllerIdentifier = "LoginViewController"

class LoginWireframe {
    
    var presenter: LoginPresenter?
    
    var loginViewController: LoginViewController?
    
    var rootWireframe : RootWireframe?
    
    var mainWireframe : MainWireframe?
    
    func showLoginModuleAsRoot() {
        loginViewController = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: LoginViewControllerIdentifier) as? LoginViewController
        
        if let loginViewController = loginViewController {
            loginViewController.loginModule = presenter
            presenter?.interface = loginViewController
            rootWireframe?.showRootViewController(viewController: loginViewController)
        } else {
            print("ERROR: View controller from storyboard not found")
        }
    }
    
    func goToMainModule() {
        mainWireframe?.showMainModuleAsRoot()
    }
}
