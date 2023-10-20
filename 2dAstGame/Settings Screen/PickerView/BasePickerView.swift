//
//  BasePickerView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 13.10.2023.
//

import UIKit

class BasePickerView: UIView {
    let baseImageView = UIImageView()
    let leftButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)
    let stackView = UIStackView()
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
    
    func setInitial() {
        currentIndex = UserDefaults.standard.integer(forKey: userDefaultsKey)
        baseImageView.image = array[currentIndex]
    }
    
    func setupUI() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        baseImageView.frame.size = AppResources.AppConstraints.SettingsScreen.pickerSize
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        
        backgroundColor = .clear
        
        baseImageView.contentMode = .scaleAspectFit
        
        baseImageView.image = array[currentIndex]
        
        leftButton.setTitle("<", for: .normal)
        leftButton.titleLabel?.font = AppResources.AppFonts.arrowSize
        
        leftButton.addTarget(self, action: #selector(selectedLeft), for: .touchUpInside)
        
        
        rightButton.setTitle(">", for: .normal)
        rightButton.titleLabel?.font = AppResources.AppFonts.arrowSize
        
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
        
        if userDefaultsKey == AppResources.AppStringsConstants.DataBase.PickerData.Barriers.barrierIndex {
            db.save(dataType: .selectedBarrier, data: name)
            
        } else if userDefaultsKey == AppResources.AppStringsConstants.DataBase.PickerData.Cars.carIndex {
            
            db.save(dataType: .selectedCar, data: name)
        }
    }
    
    @objc func selectedRight() {
        currentIndex = (currentIndex + 1) % array.count
        baseImageView.image = array[currentIndex]
        let name = getItem(currentIndex)
        
        
        if userDefaultsKey == AppResources.AppStringsConstants.DataBase.PickerData.Barriers.barrierIndex{
            db.save(dataType: .selectedBarrier, data: name)
            
        } else if userDefaultsKey == AppResources.AppStringsConstants.DataBase.PickerData.Cars.carIndex {
            
            db.save(dataType: .selectedCar, data: name)
        }
    }
    
    func getItem(_ index: Int) -> String {
        
        return imageNames[index]
    }
}

