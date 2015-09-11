//
//  RootWireframe.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 10/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe {
    
    var window: UIWindow?
    
    func showRootViewController(viewController: UIViewController) {
        if let window = window {
            if let navigationController = navigationControllerFromWindow(window) {
                navigationController.viewControllers = [viewController]
            } else {
                println("ERROR: Window cannot be nil")
            }
        } else {
            println("ERROR: Window cannot be nil")
        }
    }
    
    private func navigationControllerFromWindow(window: UIWindow) -> UINavigationController? {
        if let navigationController = window.rootViewController as? UINavigationController {
            return navigationController
        } else {
            println("ERROR: No navigation controller found")
            return nil
        }
    }
}