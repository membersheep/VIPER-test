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
    
    func fadeIn(duration: TimeInterval, delay: TimeInterval = 0.0, options:UIViewAnimationOptions = UIViewAnimationOptions.curveEaseIn, completion: ((Bool)->(Void))? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval, delay: TimeInterval = 0.0, options:UIViewAnimationOptions = UIViewAnimationOptions.curveEaseOut, completion: ((Bool)->(Void))? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
    
    func shakeAnimation(duration: TimeInterval = 0.07, repeatCount: Float = 4, offset: Float = 10) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:self.center.x - CGFloat(offset), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + CGFloat(offset), y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
