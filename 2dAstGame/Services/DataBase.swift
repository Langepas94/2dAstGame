//
//  DataBase.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import Foundation
import UIKit

protocol DataBaseProtocol {
    func save<T>(dataType: UserDefaultsKeys, data: T)
    func read<T>(dataType: UserDefaultsKeys) -> T?
}

class DataBase: DataBaseProtocol {
    
    let fileManagerWorker = FileManagerWorker()
    
    // MARK: Save
    
    func save<T>(dataType: UserDefaultsKeys, data: T) {
        
        switch dataType {
        case .name:
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.name.rawValue)
        case .avatar:
            if let image = data as? UIImage {
                fileManagerWorker.saveImage(image)
            }
        case .selectedCar:
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.selectedCar.rawValue)
        case .records:
            if let score = data as? ScoreModel {
                fileManagerWorker.saveRecords(score)
            }
        }
    }
    // MARK: Read
    
    func read<T>(dataType: UserDefaultsKeys) -> T? {
        
        switch dataType {
        case .name:
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.name.rawValue) as? T
        case .avatar:
            return fileManagerWorker.loadImage() as? T
        case .selectedCar:
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.selectedCar.rawValue) as? T
        case .records:
           return fileManagerWorker.loadRecords() as? T
        }
    }
}
