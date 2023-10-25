//
//  RoadSeparatorLayer.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit

final class RoadSeparatorAnimated: UIView {
    
    private let roadLayer = CAShapeLayer()
    private let separatorLayer = CAShapeLayer()
    private let separatorAnimation = CABasicAnimation(keyPath: "lineDashPhase")
    private var speed: CFTimeInterval = AppResources.Screens.GameScreen.GameLogic.roadSpeed

    // MARK: Stop All
    
    func stopAllAnimations() {
        layer.sublayers?.forEach({ layer in
            layer.removeAllAnimations()
        })
    }
    
    // MARK: Setup Line with speed
    
    private func setupLayers(_ speed: CFTimeInterval) {
        separatorLayer.strokeColor = AppResources.Screens.GameScreen.Colors.Road.roadLineColor
        separatorLayer.lineWidth = AppResources.Screens.GameScreen.ConstraintsAndSizes.Road.roadLineWidth
        separatorLayer.fillColor = AppResources.Screens.GameScreen.Colors.Road.betweenLine
        separatorLayer.lineDashPattern = AppResources.Screens.GameScreen.ConstraintsAndSizes.Road.lineDash
        
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
        
        setupLayers(speed)
    }
    
    // MARK: - Init's
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers(speed)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers(0)
    }
}

