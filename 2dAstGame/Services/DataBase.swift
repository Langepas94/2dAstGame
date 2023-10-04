//
//  DataBase.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import Foundation

protocol DataBaseProtocol {
    func save<T>(dataType: UserDefaultsKeys, data: T)
    func read<T>(dataType: UserDefaultsKeys) -> T?
}

class DataBase: DataBaseProtocol {
    
    // MARK: Save
    
    func save<T>(dataType: UserDefaultsKeys, data: T) {
        
        switch dataType {
        case .name:
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.name.rawValue)
        case .avatar:
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.avatar.rawValue)
        case .selectedCar:
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.selectedCar.rawValue)
        }
        
       
    }
    // MARK: Read
    func read<T>(dataType: UserDefaultsKeys) -> T? {
        
        switch dataType {
        case .name:
            return UserDefaults.standard.object(forKey: UserDefaultsKeys.name.rawValue) as? T
        case .avatar:
            return UserDefaults.standard.object(forKey: UserDefaultsKeys.avatar.rawValue) as? T
        case .selectedCar:
            return UserDefaults.standard.object(forKey: UserDefaultsKeys.selectedCar.rawValue) as? T
        }
    }
}
