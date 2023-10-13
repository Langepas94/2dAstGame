//
//  PickerView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 12.10.2023.
//

import UIKit

enum Cars: String {
    case car1 = "car1"
    case car2 = "car2"
    case car3 = "car3"
    
    static var allCases: [String] {
        return [car1.rawValue, car2.rawValue, car3.rawValue]
    }
}

class PickerView: UIView {
    let carImageView = UIImageView()
    let leftButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)
    let stackView = UIStackView()
    
    var carImages = Cars.allCases.map { name in
        UIImage(named: name)
    }
    var currentCarIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: "selectedCarIndex")
        } set {
            UserDefaults.standard.set(newValue, forKey: "selectedCarIndex")
        }
    }
    var db = DataBase()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setInitialCar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInitialCar() {
            currentCarIndex = UserDefaults.standard.integer(forKey: "selectedCarIndex")
            carImageView.image = carImages[currentCarIndex]
        }
    
    func setupUI() {
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        carImageView.frame.size = CGSize(width: 100, height: 100)
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        
        backgroundColor = .clear
        
        carImageView.contentMode = .scaleAspectFit
        
        carImageView.image = carImages[currentCarIndex]
        
        
        leftButton.setTitle("<", for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        leftButton.addTarget(self, action: #selector(selectLeftCar), for: .touchUpInside)
        
        
        rightButton.setTitle(">", for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        rightButton.addTarget(self, action: #selector(selectRightCar), for: .touchUpInside)
        
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(carImageView)
        stackView.addArrangedSubview(rightButton)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func getCar(_ index: Int) -> String {
        let array = Cars.allCases
        return array[index]
    }
    
    @objc func selectLeftCar() {
        currentCarIndex = (currentCarIndex - 1 + carImages.count) % carImages.count
        carImageView.image = carImages[currentCarIndex]
        let name = getCar(currentCarIndex)
        db.save(dataType: .selectedCar, data: name)
    }
    
    @objc func selectRightCar() {
        currentCarIndex = (currentCarIndex + 1) % carImages.count
        carImageView.image = carImages[currentCarIndex]
        let name = getCar(currentCarIndex)
        db.save(dataType: .selectedCar, data: name)
    }
    
    
}
