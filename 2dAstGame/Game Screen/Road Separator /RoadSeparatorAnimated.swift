//
//  RoadSeparatorLayer.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit

class RoadSeparatorAnimated: UIView {
    
    private let roadLayer = CAShapeLayer()
    private let separatorLayer = CAShapeLayer()
    private let separatorAnimation = CABasicAnimation(keyPath: "lineDashPhase")
    private var speed: CFTimeInterval?

    // MARK: Stop All
    
    func stopAllAnimations() {
        layer.sublayers?.forEach({ layer in
            layer.removeAllAnimations()
        })
    }
    
    // MARK: Setup Line with speed
    
    private func setupLayers(_ speed: CFTimeInterval) {
        separatorLayer.strokeColor = AppResources.GameConstants.RoadConstants.Colors.roadLineColor
        separatorLayer.lineWidth = AppResources.GameConstants.RoadConstants.Values.roadLineWidth
        separatorLayer.fillColor = AppResources.GameConstants.RoadConstants.Colors.betweenLine
        separatorLayer.lineDashPattern = AppResources.GameConstants.RoadConstants.Values.lineDash
        
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
        
        setupLayers(speed ?? 0.2)
    }
    
    // MARK: - Init's
    
    init(frame: CGRect, speed: CFTimeInterval) {
        super.init(frame: frame)
        self.speed = speed
        setupLayers(speed)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
      
        setupLayers(0)
    }
}

