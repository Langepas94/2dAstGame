//
//  RoadSeparatorLayer.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit
import QuartzCore

class RoadSeparatorAnimated: UIView {
    private let roadLayer = CAShapeLayer()
    private let separatorLayer = CAShapeLayer()
    private let separatorAnimation = CABasicAnimation(keyPath: "lineDashPhase")
    
    init(frame: CGRect, speed: CFTimeInterval) {
        super.init(frame: frame)
        setupLayers(speed)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers(0)
    }
    
    private func setupLayers(_ speed: CFTimeInterval) {
//        roadLayer.strokeColor = UIColor.gray.cgColor
//        roadLayer.lineWidth = 10
//        roadLayer.fillColor = UIColor.clear.cgColor
//        
        separatorLayer.strokeColor = UIColor.white.cgColor
        separatorLayer.lineWidth = 6
        separatorLayer.fillColor = UIColor.clear.cgColor
        separatorLayer.lineDashPattern = [26, 8]
        
//        layer.addSublayer(roadLayer)
        layer.addSublayer(separatorLayer)
        
        separatorAnimation.fromValue = NSNumber(value: 0)
        separatorAnimation.toValue = NSNumber(value: separatorLayer.lineDashPattern!.reduce(0) { $0 - $1.doubleValue })
        separatorAnimation.duration = speed
        separatorAnimation.repeatCount = .infinity
        separatorAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        separatorLayer.add(separatorAnimation, forKey: "lineDashPhase")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let roadPath = UIBezierPath()
        roadPath.move(to: CGPoint(x: 0, y: bounds.height / 2))
        roadPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
        roadLayer.path = roadPath.cgPath
        
        let separatorPath = UIBezierPath()
        separatorPath.move(to: CGPoint(x: bounds.width / 2, y: 0))
        separatorPath.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        separatorLayer.path = separatorPath.cgPath
    }
}

