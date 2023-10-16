//
//  BarrierPickerView.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 13.10.2023.
//

import Foundation
import UIKit



class BarrierPickerView: BasePickerView {
    var barriersArray = AppResources.AppStringsConstants.DataBase.PickerData.Barriers.allCases
    var barriersImages: [UIImage] = []
    var barrierUserKey: String = AppResources.AppStringsConstants.DataBase.PickerData.Barriers.barrierIndex
    init() {
        self.barriersImages = barriersArray.compactMap { name in
            return UIImage(named: name)
        }
        super.init(array: barriersArray, userDefaultsKey: barrierUserKey)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
