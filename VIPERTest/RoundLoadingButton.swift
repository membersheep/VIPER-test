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
    
    @IBInspectable public var borderBackgroundColor: UIColor = UIColor.darkGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var centerColor: UIColor = UIColor.white {
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
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    // MARK: Private functions
    
    private func setup() {
        self.backgroundColor = UIColor.clear;
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
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            self.transform = CGAffineTransform(scaleX: 0.0000001, y: 1);
            }, completion:{
                (value: Bool) in
                self.titleLabel!.text = newTitle
                self.titleLabel!.sizeToFit()
                self.isLoading = true
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1);
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
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            self.transform = CGAffineTransform(scaleX: 0.0000001, y: 1);
            }, completion:{
                (value: Bool) in
                self.titleLabel!.text = newTitle
                self.titleLabel!.sizeToFit()
                self.isLoading = false
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1);
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
        let outerRect = self.bounds.insetBy(dx: 0, dy: 0)
        let backgroundPath = UIBezierPath(ovalIn: CGRect(x: outerRect.minX, y: outerRect.minY, width: outerRect.width, height: outerRect.height))
        backgroundPath.fill();
        backgroundCircleLayer.fillColor = borderBackgroundColor.cgColor
        backgroundCircleLayer.strokeColor = UIColor.black.cgColor
        backgroundCircleLayer.path = backgroundPath.cgPath;
    }
    
    private func drawBorder() {
        borderCircleLayer.frame = self.bounds
        borderCircleLayer.instanceCount = 30
        borderCircleLayer.instanceDelay = CFTimeInterval(1 / 30.0)
        borderCircleLayer.preservesDepth = true
        borderCircleLayer.instanceColor = borderColor.cgColor
        borderCircleLayer.instanceRedOffset = 0.0
        borderCircleLayer.instanceGreenOffset = 0.0
        borderCircleLayer.instanceBlueOffset = 0.0
        borderCircleLayer.instanceAlphaOffset = 0.0
        
        let angle = Float(M_PI * 2.0) / 30
        borderCircleLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        let instanceLayer = CALayer()
        
        let midX = self.bounds.midX - borderWidth / 2.0
        instanceLayer.frame = CGRect(x: midX, y: 0.0, width: borderWidth, height: borderWidth)
        instanceLayer.backgroundColor = borderBackgroundColor.cgColor
        borderCircleLayer.addSublayer(instanceLayer)
        instanceLayer.opacity = 0.0
        
        if (isLoading) {
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.fromValue = 1.0
            fadeAnimation.toValue = 0.0
            fadeAnimation.duration = 1
            fadeAnimation.repeatCount = Float(Int.max)
            instanceLayer.add(fadeAnimation, forKey: "FadeAnimation")
        }
        else {
            for subLayer in borderCircleLayer.sublayers! {
                if subLayer is CALayer {
                    subLayer.removeAllAnimations()
                }
            }
            
        }
    }
    
    private func drawCenter() {
        let innerRect = self.bounds.insetBy(dx: borderWidth, dy: borderWidth)
        let centerPath = UIBezierPath(ovalIn: CGRect(x: innerRect.minX, y: innerRect.minY, width: innerRect.width, height: innerRect.height))
        centerPath.fill()
        centerCircleLayer.fillColor = centerColor.cgColor
        centerCircleLayer.strokeColor = UIColor.black.cgColor
        centerCircleLayer.path = centerPath.cgPath;
    }
    
    override public func draw(_ rect: CGRect) {
        self.drawBackground()
        self.drawBorder()
        self.drawCenter()
    }
}
