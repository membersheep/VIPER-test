//
//  MainViewController.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var loadingButton: RoundLoadingButton?
    
    @IBOutlet weak var settingsButton: RotatingButton?
    
    @IBOutlet weak var titleView: UIView?
    
    @IBOutlet weak var titleViewCenterConstraint: NSLayoutConstraint!
    
    // MARK: UIVIewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureButtons()
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configureButtons() {
        loadingButton!.buttonPushedClosure = buttonPushed
        loadingButton!.alpha = 0;
        
        settingsButton!.imageView!.image = settingsButton!.imageView!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        settingsButton!.tintColor = UIColor.MOREOrange()
        settingsButton!.animationEndedClosure = settingsButtonAnimationEnded
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton()
        animateTitle()
    }
    
    // MARK: Start Animations
    
    func animateButton() {
        loadingButton!.alpha = 0;
        self.loadingButton!.isUserInteractionEnabled = false;
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.loadingButton!.alpha = 1.0
            }, completion: { completed in
                self.loadingButton!.isUserInteractionEnabled = true;
        })
    }
    
    func animateTitle() {
        titleViewCenterConstraint.constant = view.frame.height / 2.0 - titleView!.frame.height / 2.0 - 64
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: { completed in
        })
    }
    
    // MARK: Start Button
    
    @IBAction func onButtonTouched() {
        loadingButton!.startLoadingAnimationWithTitle(newTitle: "Analyzing...", inTime: 0.3)
        var timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: Selector("stopLoading"), userInfo: nil, repeats: false)
    }
    
    func stopLoading() {
        loadingButton!.stopLoadingAnimationWithTitle(newTitle: "Done!", inTime: 0.3)
    }
    
    func buttonPushed() -> () {
        performSegue(withIdentifier: "analysisResultsSegue", sender: self)
    }
    
    // MARK: Settings Button
    
    @IBAction func onSettingsButtonTouched() {
        settingsButton!.rotateImageAnimation()
    }
    
    func settingsButtonAnimationEnded() -> () {
        performSegue(withIdentifier: "presentSettingsSegue", sender: self)
    }
}
