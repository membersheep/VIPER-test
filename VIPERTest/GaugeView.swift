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
    
    @IBInspectable public var needleColor: UIColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var gaugeBackgroundColor: UIColor = UIColor.red {
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
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    private func setup() {        
        self.layer.addSublayer(self.leftBackgroundLayer)
        self.layer.addSublayer(self.rightBackgroundLayer)
        self.layer.addSublayer(self.needleLayer)
        
        self.layer.contentsGravity = kCAGravityCenter
        self.isOpaque = false
        self.contentMode = UIViewContentMode.redraw
        
        let handlePanSelector: Selector = "handlePan:"
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: handlePanSelector))
    }
    
    // MARK: Drawing
    
    override public func draw(_ rect: CGRect) {
        drawBg()
        drawNeedle()
    }
    
    private func drawBg() {
        currentAngle = (endAngle - startAngle) / Float(levelsNumber) * Float(currentLevel) + startAngle
        let viewCenter = CGPoint(x: self.bounds.origin.x+self.bounds.width/2, y: self.bounds.origin.y+self.bounds.height/2)
        
        if (currentAngle > startAngle) {
            let backgroundPathLeft = UIBezierPath()
            backgroundPathLeft.move(to: viewCenter)
            backgroundPathLeft.addArc(withCenter: viewCenter, radius: CGFloat(bounds.width/2), startAngle: CGFloat(startAngle), endAngle: CGFloat(currentAngle), clockwise: true)
            leftBackgroundLayer.fillColor = gaugeBackgroundColor.cgColor
            leftBackgroundLayer.strokeColor = UIColor.black.cgColor
            leftBackgroundLayer.path = backgroundPathLeft.cgPath;
//            leftBackgroundLayer.filters
        }
       
        let backgroundPathRight = UIBezierPath()
        backgroundPathRight.move(to: viewCenter)
        backgroundPathRight.addArc(withCenter: viewCenter, radius: CGFloat(bounds.width/2), startAngle: CGFloat(currentAngle), endAngle: CGFloat(endAngle), clockwise: true)
        rightBackgroundLayer.fillColor = lightBackgroundColor.cgColor
        rightBackgroundLayer.strokeColor = UIColor.black.cgColor
        rightBackgroundLayer.path = backgroundPathRight.cgPath;
        
//        let maskLayer: CAShapeLayer = CAShapeLayer()
//        let maskPath = UIBezierPath()
//        maskPath.moveToPoint(viewCenter)
//        maskPath.addArcWithCenter(viewCenter, radius: CGFloat(bounds.width/2 * 0.7), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
//        maskLayer.fillColor = UIColor.clearColor().CGColor
//        maskLayer.path = maskPath.CGPath
//        leftBackgroundLayer.mask = maskLayer
    }
    
    private func drawNeedle() {
        let viewCenter = CGPoint(x: self.bounds.origin.x+self.bounds.width/2, y: self.bounds.origin.y+self.bounds.height/2)
        let needleRadius = CGFloat(bounds.width/2 * 0.2)
        let topPoint: CGPoint = CGPoint(x: viewCenter.x, y: viewCenter.y - bounds.height/2);
        let startPoint: CGPoint = CGPoint(x: viewCenter.x + needleRadius, y: viewCenter.y);

        let distance: CGFloat = CGFloat(bgRadius * 1.1);
        let starttime: CGFloat = 0.0;
        let endtime: CGFloat = CGFloat(M_PI);
        let topSpace: CGFloat = distance / 60.0;
        
        let topPoint1: CGPoint = CGPoint(x: viewCenter.x - topSpace, y: viewCenter.y - distance + (distance * 0.1));
        let topPoint2: CGPoint = CGPoint(x: viewCenter.x + topSpace, y: viewCenter.y - distance + (distance * 0.1));
        let finishPoint: CGPoint = CGPoint(x: viewCenter.x + CGFloat(needleRadius), y: viewCenter.y);
        
        let needlePath: UIBezierPath = UIBezierPath()
        needlePath.move(to: viewCenter)
        needlePath.addArc(withCenter: viewCenter, radius: needleRadius, startAngle: 0, endAngle: CGFloat(startAngle), clockwise: true)
        needlePath.addLine(to: topPoint)
        needlePath.addLine(to: startPoint)
        
        var translate: CGAffineTransform = CGAffineTransform(translationX: -1 * (self.bounds.origin.x + viewCenter.x), y: -1 * (self.bounds.origin.y + viewCenter.y))
        needlePath.apply(translate)
        var rotate: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(currentAngle + Float(M_PI_2)))
        needlePath.apply(rotate)
        translate = CGAffineTransform(translationX: (self.bounds.origin.x + viewCenter.x), y: (self.bounds.origin.y + viewCenter.y))
        needlePath.apply(translate)
        
        needleColor.set()
        needleLayer.fillColor = needleColor.cgColor
        needleLayer.strokeColor = UIColor.black.cgColor
        needleLayer.path = needlePath.cgPath;
        
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
