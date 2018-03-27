//
//  RotatingButton.swift
//  MORE
//
//  Created by Alessandro Maroso on 15/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RotatingButton: UIButton {

    @IBInspectable var animationDuration: Float = 1.0

    @IBInspectable var rotationDegrees: Int = 180 {
        didSet {
            targetRotation = CGFloat(Double(rotationDegrees) / Double(180.0) * M_PI)
        }
    }
    
    private var targetRotation: CGFloat = CGFloat(M_PI)
    
    // MARK: Init
    
    required override  init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    var animationEndedClosure: (() -> ())?

    // Mark: Custom Animation
    
    func rotateImageAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.animationEndedClosure!();
        })
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = targetRotation
        rotateAnimation.duration = Double(animationDuration)
        layer.add(rotateAnimation, forKey: "rotationAnimation");
        CATransaction.commit()
    }
    
    
}
