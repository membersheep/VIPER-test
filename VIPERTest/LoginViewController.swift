//
//  LoginViewController.swift
//  VIPERTest
//
//  Created by Alessandro Maroso on 11/09/15.
//  Copyright (c) 2015 membersheep. All rights reserved.
//

import UIKit

/// The LoginViewController contains logic for reacting to user inputs and to configure and animate views.
class LoginViewController: UIViewController, UITextFieldDelegate, LoginUserInterface {
    
    var loginModule: LoginModuleInterface?
    
    @IBOutlet weak var scrollView: UIScrollView?
    
    var scrollViewOffset: CGPoint = CGPoint.zero
    
    @IBOutlet weak var titleView: UIView?
    
    @IBOutlet weak var titleViewCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField?
    
    @IBOutlet weak var mailTextField: UITextField?
    
    @IBOutlet weak var saveButton: UIButton?
    
    // MARK: UIViewController methods (Controller)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViews()
        
        loginModule?.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerToKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        usernameTextField!.alpha = 0;
        mailTextField!.alpha = 0;
        saveButton!.alpha = 0;
        
        fadeInTextFieldsAndButton()
        slideUpTitle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterFromKeyboardNotifications()
    }
    
    // MARK: Keyboard events methods (Controller)
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let textFieldBottomPoint = view.bounds.height - mailTextField!.frame.origin.y - mailTextField!.frame.height
        scrollView?.setContentOffset(CGPoint(x: 0, y: keyboardHeight - textFieldBottomPoint + 8.0), animated: true)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scrollView?.setContentOffset(CGPoint(x: scrollViewOffset.x, y: scrollViewOffset.y), animated: true)
    }
    
    // MARK: Touch events delegate methods (Controller)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: UITextField delegate methods (Controller)
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTextField?.resignFirstResponder()
        mailTextField?.resignFirstResponder()
        return true;
    }
    
    // MARK: Save Button (Controller)
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        if let usernameTextField = usernameTextField, let mailTextField = mailTextField {
            loginModule?.saveUserData(username: usernameTextField.text!, mailAddress: mailTextField.text!)
        } else {
            print("ERROR: usernameTextField or mailTextField not found")
        }
    }
    
    // MARK: Interface protocol methods
    
    func showInvalidCredentialsError() {
        shakeTextFields()
    }
    
    func updateTextFieldsWithUsername(username: String, andAddress mailAddress: String) {
        usernameTextField?.text = username
        mailTextField?.text = mailAddress
    }
    
    func prepareToGoToNextModule(completion: ((Bool) -> Void)?) {
        fadeOutTextFieldsAndButton()
        slideDownTitle(completion: completion)
    }
    
    // MARK: PRIVATE
    
    // MARK: UI Configuration methods
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureViews() {
        usernameTextField!.layer.borderColor = UIColor.MOREOrange().cgColor
        usernameTextField!.layer.borderWidth = 2.0;
        usernameTextField!.layer.cornerRadius = 8.0;
        usernameTextField!.layer.masksToBounds = true;
        usernameTextField!.delegate = self
        
        mailTextField!.layer.borderColor = UIColor.MOREOrange().cgColor
        mailTextField!.layer.borderWidth = 2.0;
        mailTextField!.layer.cornerRadius = 8.0;
        mailTextField!.layer.masksToBounds = true;
        mailTextField!.delegate = self
        
        saveButton!.layer.borderColor = UIColor.MOREGray().cgColor
        saveButton!.layer.borderWidth = 2.0;
        saveButton!.layer.cornerRadius = 8.0;
        saveButton!.layer.masksToBounds = true;
    }
    
    private func registerToKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func unregisterFromKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Animations
    
    private func slideUpTitle() {
        titleViewCenterConstraint.constant = view.frame.height / 2.0 - titleView!.frame.height / 2.0 - 64
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: { completed in
        })
        
    }
    
    private func slideDownTitle(completion: ((Bool) -> Void)?) {
        titleViewCenterConstraint.constant = 0
        UIView.animate(withDuration: 1.0, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: completion)
    }
    
    private func fadeInTextFieldsAndButton() {
        usernameTextField?.fadeIn(duration: 1.0, delay: 1.0)
        mailTextField?.fadeIn(duration: 1.0, delay: 1.0)
        saveButton?.fadeIn(duration: 1.0, delay: 1.0)
    }
    
    private func fadeOutTextFieldsAndButton() {
        usernameTextField?.fadeOut(duration: 1.0, delay: 0.0)
        mailTextField?.fadeOut(duration: 1.0, delay: 0.0)
        saveButton?.fadeOut(duration: 1.0, delay: 0.0)
    }
    
    private func shakeTextFields() {
        usernameTextField?.shakeAnimation()
        mailTextField?.shakeAnimation()
    }
}
