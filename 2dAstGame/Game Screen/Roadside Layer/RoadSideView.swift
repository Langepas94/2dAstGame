//
//  RoadSideView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit

final class RoadSideView: UIView {
    
    private let leftSide = UIView()
    private let rightSide = UIView()
    private var width = CGFloat()
    
    // MARK: Ширина дороги
    func roadSideWidth() {
        leftSide.frame = CGRect(x: 0, y: 0, width: self.width, height: bounds.height)
        rightSide.frame = CGRect(x: bounds.maxX - self.width, y: 0, width: width, height: bounds.height)
    }
    
    // MARK: фреймы каждой отдельной обочины
    func roadsideFrames() -> (CGRect, CGRect) {
        let leftRect = leftSide.frame
        let rightRect = rightSide.frame
        
        return (leftRect, rightRect)
    }
    
    // MARK: фрейм между двумя обочинами
    func roadsideFrameInside() -> (CGFloat, CGFloat) {
        let leftRect = leftSide.frame.maxX
        let rightRect = rightSide.frame.minX
        
        return (leftRect, rightRect)
    }
    
    // MARK: setup UI
    
    private func setupSideViews() {
        backgroundColor = .gray.withAlphaComponent(0.3)
        leftSide.backgroundColor = .orange
        rightSide.backgroundColor = .orange
        addSubview(leftSide)
        addSubview(rightSide)
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roadSideWidth()
    }
    
    // MARK: - Init's
    
    init(frame: CGRect, roadsideWidth: CGFloat) {
        super.init(frame: frame)
        setupSideViews()
        self.width = roadsideWidth
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
