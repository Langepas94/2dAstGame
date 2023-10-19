//
//  PickerView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 12.10.2023.
//

import UIKit



class CarPickerView: BasePickerView {
    var carsArray = AppResources.AppStringsConstants.DataBase.PickerData.Cars.allCases
    var carsImages: [UIImage] = []
    var carsUserKey: String = AppResources.AppStringsConstants.DataBase.PickerData.Cars.carIndex
    init() {
        self.carsImages = carsArray.compactMap { name in
            return UIImage(named: name)
        }
        super.init(array: carsArray, userDefaultsKey: carsUserKey)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

