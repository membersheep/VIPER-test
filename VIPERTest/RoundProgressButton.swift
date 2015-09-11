//
//  RoundProgressButton.swift
//  MORE
//
//  Created by Alessandro Maroso on 22/05/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class RoundProgressButton: UIButton {

    // MARK: Constants
    
    let backgroundCircleLayer: CAShapeLayer! = CAShapeLayer()
    let borderCircleLayer: CAShapeLayer! = CAShapeLayer()
    let centerCircleLayer: CAShapeLayer! = CAShapeLayer()

    // MARK: Private vars
    
    // MARK: Public vars
    
    /// Progress value between 0 an 1
    @IBInspectable public var progress: Double = 0.75 {
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
    
    /// Creates and returns the path to draw the stroke on
    ///
    /// :returns: the path to draw the stroke on
    private func borderCirclePath() -> UIBezierPath {
        let center = CGPointMake(self.bounds.midX, self.bounds.midY)
        let radius = self.bounds.width / 2.0
        let startAngle:CGFloat = CGFloat(270.0 * M_PI / 180.0)
        let endAngle:CGFloat = CGFloat((1 * 360.0 + 270.0) * M_PI / 180.0)
        var borderPath = UIBezierPath()
        borderPath.addArcWithCenter(center, radius:radius-borderWidth/2, startAngle:startAngle, endAngle:endAngle, clockwise:true)
        return borderPath
    }

    // MARK: Public funcitions
    /// Animates the progress stroke to the target value in a specified time
    /// 
    /// :param: targetProgress The target progress value, between 0 an 1
    /// :param: duration The duration of the animation in seconds
    public func animateToProgress(targetProgress: Double, inTime duration: Double) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration;
        animation.fromValue = 0.0
        animation.toValue = targetProgress
        borderCircleLayer.strokeEnd = CGFloat(targetProgress)
        borderCircleLayer.addAnimation(animation, forKey: "path")
        
        // Flip the view after completion and change label text
        UIView.animateWithDuration(0.2, delay: duration, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.transform = CGAffineTransformMakeScale(0.0000001, 1);
            }, completion:{
                (value: Bool) in
                self.titleLabel!.text = " Done!"
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                    self.transform = CGAffineTransformMakeScale(1, 1);
                    }, completion:{
                        (value: Bool) in
                        return
                })
        })
    }
    
    override public func drawRect(rect: CGRect) {
        let innerRect = CGRectInset(rect, borderWidth, borderWidth)
        let outerRect = CGRectInset(rect, 0, 0)
        
        // Background Drawing
        let backgroundPath = UIBezierPath(ovalInRect: CGRectMake(outerRect.minX, outerRect.minY, CGRectGetWidth(outerRect), CGRectGetHeight(outerRect)))
        backgroundPath.fill();
        backgroundCircleLayer.fillColor = borderBackgroundColor.CGColor
        backgroundCircleLayer.strokeColor = UIColor.blackColor().CGColor
        backgroundCircleLayer.path = backgroundPath.CGPath;
        
        // Progress Drawing
        let borderPath = borderCirclePath()
        borderCircleLayer.strokeStart = 0.0;
        borderCircleLayer.strokeEnd = CGFloat(progress);
        borderCircleLayer.strokeColor = borderColor.CGColor
        borderCircleLayer.fillColor = borderBackgroundColor.CGColor
        borderCircleLayer.lineCap = kCALineCapRound
        borderCircleLayer.lineWidth = borderWidth
        borderCircleLayer.path = borderPath.CGPath

        // Center Drawing
        let centerPath = UIBezierPath(ovalInRect: CGRectMake(innerRect.minX, innerRect.minY, CGRectGetWidth(innerRect), CGRectGetHeight(innerRect)))
        centerPath.fill()
        centerCircleLayer.fillColor = centerColor.CGColor
        centerCircleLayer.strokeColor = UIColor.blackColor().CGColor
        centerCircleLayer.path = centerPath.CGPath;
    }
}