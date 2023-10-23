//
//  BaseButtonView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class BaseButtonView: UIButton {
    
    private func setupAppearance() {
        backgroundColor = AppResources.UniqueConstants.ColorsImages.backgroundColor
        setTitleColor(AppResources.Screens.MainScreen.Colors.buttonTitle, for: .normal)
        titleLabel?.font = AppResources.UniqueConstants.Fonts.pixelFont
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = AppResources.Screens.MainScreen.ConstraintsAndSizes.BaseButton.cornerRadius
        layer.shadowColor = AppResources.Screens.MainScreen.Colors.buttonTitle.cgColor
        layer.shadowOpacity = AppResources.Screens.MainScreen.ConstraintsAndSizes.BaseButton.shadowOpacity
        layer.shadowOffset = AppResources.Screens.MainScreen.ConstraintsAndSizes.BaseButton.shadowOffset
        layer.shadowRadius = AppResources.Screens.MainScreen.ConstraintsAndSizes.BaseButton.shadowRadius
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
