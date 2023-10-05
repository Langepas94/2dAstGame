//
//  RoadSideView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit

class RoadSideView: UIView {
    
    private let leftSide = UIView()
    private let rightSide = UIView()
    private var width = CGFloat()
    
    init(frame: CGRect, roadsideWidth: CGFloat) {
        super.init(frame: frame)
        setupSideViews()
        self.width = roadsideWidth
    }
    
    func roadSideWidth() {
        leftSide.frame = CGRect(x: 0, y: 0, width: self.width, height: bounds.height)
        rightSide.frame = CGRect(x: bounds.maxX - self.width, y: 0, width: width, height: bounds.height)
    }
    
    private func setupSideViews() {
        leftSide.backgroundColor = .orange
        rightSide.backgroundColor = .orange
        
        addSubview(leftSide)
        addSubview(rightSide)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roadSideWidth()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
