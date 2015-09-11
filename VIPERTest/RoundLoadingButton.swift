//
//  RoundLoadingButton.swift
//  MORE
//
//  Created by Alessandro Maroso on 29/05/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class RoundLoadingButton: UIButton {
    
    // MARK: Constants
    
    let backgroundCircleLayer: CAShapeLayer! = CAShapeLayer()
    
    let borderCircleLayer: CAReplicatorLayer! = CAReplicatorLayer()
    
    let centerCircleLayer: CAShapeLayer! = CAShapeLayer()
    
    // MARK: Private vars
    
    // MARK: Public vars
    
    var buttonPushedClosure: (() -> ())?
    
    /// Progress value between 0 an 1
    @IBInspectable public var isLoading: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderBackgroundColor: UIColor = UIColor.darkGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.grayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var centerColor: UIColor = UIColor.whiteColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Init
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: Private functions
    
    private func setup() {
        self.backgroundColor = UIColor.clearColor();
        self.layer.addSublayer(self.backgroundCircleLayer)
        self.layer.addSublayer(self.borderCircleLayer)
        self.layer.addSublayer(self.centerCircleLayer)
    }
    
    // MARK: Public funcitions
    /// Animates the loading stroke
    ///
    /// :param: newTitle The new button title to be displayed
    /// :param: duration The duration of the flip animation in seconds
    public func startLoadingAnimationWithTitle(newTitle: String, inTime duration: Double) {
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.transform = CGAffineTransformMakeScale(0.0000001, 1);
            }, completion:{
                (value: Bool) in
                self.titleLabel!.text = newTitle
                self.titleLabel!.sizeToFit()
                self.isLoading = true
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                    self.transform = CGAffineTransformMakeScale(1, 1);
                    }, completion:{
                        (value: Bool) in
                        return
                })
        })
    }
    
    /// Stops animating the loading stroke
    ///
    /// :param: newTitle The new button title to be displayed
    /// :param: duration The duration of the flip animation in seconds
    public func stopLoadingAnimationWithTitle(newTitle: String, inTime duration: Double) {
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.transform = CGAffineTransformMakeScale(0.0000001, 1);
            }, completion:{
                (value: Bool) in
                self.titleLabel!.text = newTitle
                self.titleLabel!.sizeToFit()
                self.isLoading = false
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                    self.transform = CGAffineTransformMakeScale(1, 1);
                    }, completion:{
                        (value: Bool) in
                        if (value) {
                            self.buttonPushedClosure!();
                        }
                        return
                })
        })
    }
    
    private func drawBackground() {
        let outerRect = CGRectInset(self.bounds, 0, 0)
        let backgroundPath = UIBezierPath(ovalInRect: CGRectMake(outerRect.minX, outerRect.minY, CGRectGetWidth(outerRect), CGRectGetHeight(outerRect)))
        backgroundPath.fill();
        backgroundCircleLayer.fillColor = borderBackgroundColor.CGColor
        backgroundCircleLayer.strokeColor = UIColor.blackColor().CGColor
        backgroundCircleLayer.path = backgroundPath.CGPath;
    }
    
    private func drawBorder() {
        borderCircleLayer.frame = self.bounds
        borderCircleLayer.instanceCount = 30
        borderCircleLayer.instanceDelay = CFTimeInterval(1 / 30.0)
        borderCircleLayer.preservesDepth = true
        borderCircleLayer.instanceColor = borderColor.CGColor
        borderCircleLayer.instanceRedOffset = 0.0
        borderCircleLayer.instanceGreenOffset = 0.0
        borderCircleLayer.instanceBlueOffset = 0.0
        borderCircleLayer.instanceAlphaOffset = 0.0
        
        let angle = Float(M_PI * 2.0) / 30
        borderCircleLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        let instanceLayer = CALayer()
        let midX = CGRectGetMidX(self.bounds) - borderWidth / 2.0
        instanceLayer.frame = CGRect(x: midX, y: 0.0, width: borderWidth, height: borderWidth)
        instanceLayer.backgroundColor = borderBackgroundColor.CGColor
        borderCircleLayer.addSublayer(instanceLayer)
        instanceLayer.opacity = 0.0
        
        if (isLoading) {
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.fromValue = 1.0
            fadeAnimation.toValue = 0.0
            fadeAnimation.duration = 1
            fadeAnimation.repeatCount = Float(Int.max)
            instanceLayer.addAnimation(fadeAnimation, forKey: "FadeAnimation")
        }
        else {
            for subLayer in borderCircleLayer.sublayers {
                if subLayer is CALayer {
                    subLayer.removeAllAnimations()
                }
            }
            
        }
    }
    
    private func drawCenter() {
        let innerRect = CGRectInset(self.bounds, borderWidth, borderWidth)
        let centerPath = UIBezierPath(ovalInRect: CGRectMake(innerRect.minX, innerRect.minY, CGRectGetWidth(innerRect), CGRectGetHeight(innerRect)))
        centerPath.fill()
        centerCircleLayer.fillColor = centerColor.CGColor
        centerCircleLayer.strokeColor = UIColor.blackColor().CGColor
        centerCircleLayer.path = centerPath.CGPath;
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawBackground()
        self.drawBorder()
        self.drawCenter()
    }
}