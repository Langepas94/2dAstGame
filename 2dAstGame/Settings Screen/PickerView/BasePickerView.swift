//
//  BasePickerView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 13.10.2023.
//

import UIKit

class BasePickerView: UIView {
    
    let baseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: AppResources.Screens.SettingsScreen.Selector.Images.selectorPrevious), for: .normal)

        button.sizeToFit()
        return button
    }()
    let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: AppResources.Screens.SettingsScreen.Selector.Images.selectorNext), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var db = DataBase()
    var array: [UIImage]
    var imageNames: [String]
    var userDefaultsKey: String = ""
    var currentIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: userDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        }
    }
    
    // MARK: Flow
    func setInitial() {
        currentIndex = UserDefaults.standard.integer(forKey: userDefaultsKey)
        baseImageView.image = array[currentIndex]
    }
    
    // MARK: - Setup UI
    func setupUI() {
        
        addSubview(stackView)
        baseImageView.frame.size = AppResources.Screens.SettingsScreen.ConstraintsAndSizes.pickerSize

        backgroundColor = .clear
        
        baseImageView.image = array[currentIndex]
        
        leftButton.addTarget(self, action: #selector(selectedLeft), for: .touchUpInside)
        
        rightButton.addTarget(self, action: #selector(selectedRight), for: .touchUpInside)
        
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(baseImageView)
        stackView.addArrangedSubview(rightButton)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc func selectedLeft() {
        currentIndex = (currentIndex - 1 + array.count) % array.count
        baseImageView.image = array[currentIndex]
        let name = getItem(currentIndex)
        
        if userDefaultsKey == AppResources.UniqueConstants.DataBase.PickerData.Barriers.barrierIndex {
            db.save(dataType: .selectedBarrier, data: name)
            
        } else if userDefaultsKey == AppResources.UniqueConstants.DataBase.PickerData.Cars.carIndex {
            
            db.save(dataType: .selectedCar, data: name)
        }
    }
    
    @objc func selectedRight() {
        currentIndex = (currentIndex + 1) % array.count
        baseImageView.image = array[currentIndex]
        let name = getItem(currentIndex)
        
        
        if userDefaultsKey == AppResources.UniqueConstants.DataBase.PickerData.Barriers.barrierIndex{
            db.save(dataType: .selectedBarrier, data: name)
            
        } else if userDefaultsKey == AppResources.UniqueConstants.DataBase.PickerData.Cars.carIndex {
            
            db.save(dataType: .selectedCar, data: name)
        }
    }
    
    func getItem(_ index: Int) -> String {
        return imageNames[index]
    }
    
    // MARK: - Init's
    init(array: [String], userDefaultsKey: String) {
        self.imageNames = array
        self.array = array.compactMap { name in
            return UIImage(named: name)
        }
        super.init(frame: .zero)
        self.userDefaultsKey = userDefaultsKey
        setupUI()
        setInitial()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

