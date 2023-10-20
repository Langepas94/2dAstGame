//
//  DataBase.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import Foundation
import UIKit

protocol DataBaseProtocol {
    func save<T>(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys, data: T)
    func read<T>(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys) -> T?
}

class DataBase: DataBaseProtocol {
    
    let fileManagerWorker = FileManagerWorker()
    
    // MARK: Save
    
    func save<T>(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys, data: T) {
        
        switch dataType {
        case .name:
            UserDefaults.standard.setValue(data, forKey: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.name.rawValue)
        case .avatar:
            if let image = data as? UIImage {
                fileManagerWorker.saveImage(image)
            }
        case .selectedCar:
            UserDefaults.standard.setValue(data, forKey: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedCar.rawValue)
        case .records:
            if let score = data as? ScoreModel {
                fileManagerWorker.saveRecords(score)
            }
        case .selectedBarrier:
            UserDefaults.standard.setValue(data, forKey: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedBarrier.rawValue)
        }
    }
    // MARK: Read
    
    func read<T>(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys) -> T? {
        
        switch dataType {
        case .name:
            return UserDefaults.standard.string(forKey: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.name.rawValue) as? T ?? AppResources.AppStringsConstants.DataBase.defaultName as? T
        case .avatar:
            return fileManagerWorker.loadImage() as? T
        case .selectedCar:
            return UserDefaults.standard.string(forKey: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedCar.rawValue) as? T ??  AppResources.AppStringsConstants.DataBase.PickerData.Cars.car1.rawValue as? T
        case .records:
            return fileManagerWorker.loadRecords() as? T
        case .selectedBarrier:
            return UserDefaults.standard.string(forKey: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedBarrier.rawValue) as? T ?? AppResources.AppStringsConstants.DataBase.PickerData.Barriers.barrier1.rawValue as? T
        }
    }
}
