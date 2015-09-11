//
//  MockRootWireframe.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import UIKit

class MockRootWireframe: RootWireframe {
    
    var viewControllerShown: UIViewController?
    
    override func showRootViewController(viewController: UIViewController) {
        viewControllerShown = viewController
    }
}