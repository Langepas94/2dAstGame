//
//  BaseButtonView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class BaseButtonView: UIButton {
    
    private func setupAppearance() {
        backgroundColor = AppResources.AppScreenUIColors.backgroundColor
        setTitleColor(AppResources.AppScreenUIColors.buttonTitle, for: .normal)
        titleLabel?.font = AppResources.AppFonts.buttonFont
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
    }
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
