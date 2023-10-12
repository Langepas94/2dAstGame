//
//  PickerView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 12.10.2023.
//

import UIKit

class PickerView: UIView {
    let carImageView = UIImageView()
    let leftButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)
    let stackView = UIStackView()
    var carImages = [UIImage(named: "car1"), UIImage(named: "car2"), UIImage(named: "car3")]
    var currentCarIndex = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        //            carImageView/*.frame = CGRect(x: 50, y: 100, width: 200, height: 200)*/
        carImageView.image = carImages[currentCarIndex]
        //            addSubview(carImageView)
        
        leftButton.setTitle("<", for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        //            leftButton.frame = CGRect(x: 50, y: 350, width: 100, height: 50)
        leftButton.addTarget(self, action: #selector(selectLeftCar), for: .touchUpInside)
        //            addSubview(leftButton)
        
        rightButton.setTitle(">", for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        //            rightButton.frame = CGRect(x: 150, y: 350, width: 100, height: 50)
        rightButton.addTarget(self, action: #selector(selectRightCar), for: .touchUpInside)
        //            addSubview(rightButton)
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
    
    @objc func selectLeftCar() {
        currentCarIndex = (currentCarIndex - 1 + carImages.count) % carImages.count
        carImageView.image = carImages[currentCarIndex]
    }
    
    @objc func selectRightCar() {
        currentCarIndex = (currentCarIndex + 1) % carImages.count
        carImageView.image = carImages[currentCarIndex]
    }
    
    
}
