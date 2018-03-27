//
//  MainWireframe.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import UIKit

let MainViewControllerIdentifier = "MainViewController"

class MainWireframe {
    var presenter: MainPresenter?
    
    var mainViewController: MainViewController?
    
    var rootWireframe : RootWireframe?
    
    func showMainModuleAsRoot() {
        mainViewController = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: MainViewControllerIdentifier) as? MainViewController

        if let mainViewController = mainViewController {
            //            mainViewController.mainModule = presenter
            //            presenter?.interface = mainViewController
            rootWireframe?.showRootViewController(viewController: mainViewController)
        } else {
            print("ERROR: View controller from storyboard not found")
        }
        
    }
}
