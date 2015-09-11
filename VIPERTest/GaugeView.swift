//
//  GaugeView.swift
//  MORE
//
//  Created by Alessandro Maroso on 09/06/15.
//  Copyright (c) 2015 IKS. All rights reserved.
//

import Foundation
import UIKit

//TODO: Comment public methods

@IBDesignable public class GaugeView: UIView {
    
    // MARK: Layers
    
    let leftBackgroundLayer: CAShapeLayer! = CAShapeLayer()
    
    let rightBackgroundLayer: CAShapeLayer! = CAShapeLayer()
    
    let needleLayer: CAShapeLayer! = CAShapeLayer()
    
    // MARK: Public vars
    
    @IBInspectable public var needleColor: UIColor = UIColor.whiteColor() {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var gaugeBackgroundColor: UIColor = UIColor.redColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lightBackgroundColor: UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        gaugeBackgroundColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r, green: g, blue: b, alpha: a/2.0)
    }
    
    @IBInspectable public var levelsNumber: Int = 4 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var currentLevel: Int = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var delegate: GaugeViewDelegate?
    
    // MARK: Private vars
    private var startAngle: Float = Float(M_PI*1.1)
    
    private var endAngle: Float = Float(M_PI*1.9)
    
    private var bgRadius: Float = 0
    
    private var currentAngle: Float = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var scale: Int = 0
    
    // MARK: Init
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {        
        self.layer.addSublayer(self.leftBackgroundLayer)
        self.layer.addSublayer(self.rightBackgroundLayer)
        self.layer.addSublayer(self.needleLayer)
        
        self.layer.contentsGravity = kCAGravityCenter
        self.opaque = false
        self.contentMode = UIViewContentMode.Redraw
        
        let handlePanSelector: Selector = "handlePan:"
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: handlePanSelector))
    }
    
    // MARK: Drawing
    
    override public func drawRect(rect: CGRect) {
        drawBg()
        drawNeedle()
    }
    
    private func drawBg() {
        currentAngle = (endAngle - startAngle) / Float(levelsNumber) * Float(currentLevel) + startAngle
        let viewCenter = CGPointMake(self.bounds.origin.x+self.bounds.width/2, self.bounds.origin.y+self.bounds.height/2)
        
        if (currentAngle > startAngle) {
            let backgroundPathLeft = UIBezierPath()
            backgroundPathLeft.moveToPoint(viewCenter)
            backgroundPathLeft.addArcWithCenter(viewCenter, radius: CGFloat(bounds.width/2), startAngle: CGFloat(startAngle), endAngle: CGFloat(currentAngle), clockwise: true)
            leftBackgroundLayer.fillColor = gaugeBackgroundColor.CGColor
            leftBackgroundLayer.strokeColor = UIColor.blackColor().CGColor
            leftBackgroundLayer.path = backgroundPathLeft.CGPath;
//            leftBackgroundLayer.filters
        }
       
        let backgroundPathRight = UIBezierPath()
        backgroundPathRight.moveToPoint(viewCenter)
        backgroundPathRight.addArcWithCenter(viewCenter, radius: CGFloat(bounds.width/2), startAngle: CGFloat(currentAngle), endAngle: CGFloat(endAngle), clockwise: true)
        rightBackgroundLayer.fillColor = lightBackgroundColor.CGColor
        rightBackgroundLayer.strokeColor = UIColor.blackColor().CGColor
        rightBackgroundLayer.path = backgroundPathRight.CGPath;
        
//        let maskLayer: CAShapeLayer = CAShapeLayer()
//        let maskPath = UIBezierPath()
//        maskPath.moveToPoint(viewCenter)
//        maskPath.addArcWithCenter(viewCenter, radius: CGFloat(bounds.width/2 * 0.7), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
//        maskLayer.fillColor = UIColor.clearColor().CGColor
//        maskLayer.path = maskPath.CGPath
//        leftBackgroundLayer.mask = maskLayer
    }
    
    private func drawNeedle() {
        let viewCenter = CGPointMake(self.bounds.origin.x+self.bounds.width/2, self.bounds.origin.y+self.bounds.height/2)
        let needleRadius = CGFloat(bounds.width/2 * 0.2)
        let topPoint: CGPoint = CGPointMake(viewCenter.x, viewCenter.y - bounds.height/2);
        let startPoint: CGPoint = CGPointMake(viewCenter.x + needleRadius, viewCenter.y);

        let distance: CGFloat = CGFloat(bgRadius * 1.1);
        let starttime: CGFloat = 0.0;
        let endtime: CGFloat = CGFloat(M_PI);
        let topSpace: CGFloat = distance / 60.0;
        
        let topPoint1: CGPoint = CGPointMake(viewCenter.x - topSpace, viewCenter.y - distance + (distance * 0.1));
        let topPoint2: CGPoint = CGPointMake(viewCenter.x + topSpace, viewCenter.y - distance + (distance * 0.1));
        let finishPoint: CGPoint = CGPointMake(viewCenter.x + CGFloat(needleRadius), viewCenter.y);
        
        let needlePath: UIBezierPath = UIBezierPath()
        needlePath.moveToPoint(viewCenter)
        needlePath.addArcWithCenter(viewCenter, radius: needleRadius, startAngle: 0, endAngle: CGFloat(startAngle), clockwise: true)
        needlePath.addLineToPoint(topPoint)
        needlePath.addLineToPoint(startPoint)
        
        var translate: CGAffineTransform = CGAffineTransformMakeTranslation(-1 * (self.bounds.origin.x + viewCenter.x), -1 * (self.bounds.origin.y + viewCenter.y))
        needlePath.applyTransform(translate)
        var rotate: CGAffineTransform = CGAffineTransformMakeRotation(CGFloat(currentAngle + Float(M_PI_2)))
        needlePath.applyTransform(rotate)
        translate = CGAffineTransformMakeTranslation((self.bounds.origin.x + viewCenter.x), (self.bounds.origin.y + viewCenter.y))
        needlePath.applyTransform(translate)
        
        needleColor.set()
        needleLayer.fillColor = needleColor.CGColor
        needleLayer.strokeColor = UIColor.blackColor().CGColor
        needleLayer.path = needlePath.CGPath;
        
    }
    
    private func drawLabels() {
        
    }
    
    // MARK: Pan gesture recognizer
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
    }
}

public protocol GaugeViewDelegate {
    func gaugeView(gaugeView:GaugeView, didChangeLevel level:Int)
}