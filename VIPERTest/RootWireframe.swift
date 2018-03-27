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
            if let navigationController = navigationControllerFromWindow(window: window) {
                navigationController.viewControllers = [viewController]
            } else {
                print("ERROR: Window cannot be nil")
            }
        } else {
            print("ERROR: Window cannot be nil")
        }
    }
    
    private func navigationControllerFromWindow(window: UIWindow) -> UINavigationController? {
        if let navigationController = window.rootViewController as? UINavigationController {
            return navigationController
        } else {
            print("ERROR: No navigation controller found")
            return nil
        }
    }
}
