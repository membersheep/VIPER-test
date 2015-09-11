//
//  AppInitializer.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 10/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation
import UIKit

class AppInitializer {
    
    let rootWireframe: RootWireframe = RootWireframe()
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        
        rootWireframe.window = window
        
        // INIT MAIN MODULE
        let mainWireframe = MainWireframe()
        let mainPresenter = MainPresenter()
        let mainInteractor = MainInteractor()
        
        //            mainWireframe.presenter = mainPresenter
        mainWireframe.rootWireframe = rootWireframe
        //
        //            mainPresenter.interactor = mainInteractor
        //            mainPresenter.wireframe = mainWireframe
        //
        //            mainInteractor.delegate = mainPresenter
        
        if let currentUser = LoginDataManager().getCurrentUser() {
            mainWireframe.showMainModuleAsRoot()
        } else {
            // INIT LOGIN MODULE
            let loginWireframe = LoginWireframe()
            let loginPresenter = LoginPresenter()
            let loginInteractor = LoginInteractor()
            
            loginWireframe.presenter = loginPresenter
            loginWireframe.rootWireframe = rootWireframe
            loginWireframe.mainWireframe = mainWireframe
            
            loginPresenter.interactor = loginInteractor
            loginPresenter.wireframe = loginWireframe
            
            loginInteractor.delegate = loginPresenter
            
            loginWireframe.showLoginModuleAsRoot()
        }
    }
}