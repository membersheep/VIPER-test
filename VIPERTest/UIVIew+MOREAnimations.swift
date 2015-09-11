//
//  UIVIew+MOREAnimations.swift
//  MORE
//
//  Created by Alessandro Maroso on 19/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation
import UIKit

enum SlideDirection {
    case Up
    case Dowm
}

extension UIView {
    
    func fadeIn(duration: NSTimeInterval, delay: NSTimeInterval = 0.0, options:UIViewAnimationOptions = UIViewAnimationOptions.allZeros, completion: ((Bool)->(Void))? = nil) {
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: NSTimeInterval, delay: NSTimeInterval = 0.0, options:UIViewAnimationOptions = UIViewAnimationOptions.allZeros, completion: ((Bool)->(Void))? = nil) {
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
    
    func shakeAnimation(duration: NSTimeInterval = 0.07, repeatCount: Float = 4, offset: Float = 10) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - CGFloat(offset), self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + CGFloat(offset), self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
    }
}