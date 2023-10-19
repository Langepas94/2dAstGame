//
//  Resources.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import Foundation
import UIKit

enum AppResources {
    
    enum AppScreenUIColors {
        
        static let backgroundColor = UIColor.yellow
        static let buttonTitle = UIColor.black
        static let buttonBackground = UIColor.green
        static let mainText = UIColor.black
    }

    enum AppFonts {
        static let buttonFont = UIFont.systemFont(ofSize: 23)
        static let usernameFont = UIFont.systemFont(ofSize: 36)
        static let cellFont = UIFont.systemFont(ofSize: 25)
        static let gameScore = UIFont.systemFont(ofSize: 25)
        static let arrowSize = UIFont.systemFont(ofSize: 30)
    }

    enum AppConstraints {
        
        enum MainScreen {
            static let stackViewSize = CGSize(width: 200, height: 200)
            enum BaseButton {
                static let size = CGSize(width: 100, height: 100)
            }
           
        }
        
        enum SettingsScreen {
            static let pickerSize = CGSize(width: 100, height: 100)
            
            enum Image {
                static let top = CGFloat(36)
                static let leading = CGFloat(36)
                static let trailing = CGFloat(-36)
            }
            
            enum Name {
                static let top = CGFloat(6)
                static let leading = CGFloat(36)
                static let trailing = CGFloat(-36)
            }
            
            enum CarPicker {
                static let top = CGFloat(6)
               
                static let height = CGFloat(160)
            }
            
            enum BarrierPicker {
                static let top = CGFloat(6)
                static let height = CGFloat(160)
            }
        }
        
        enum Table {
            static let heightRow = CGFloat(50)
            static let heightForHeader = CGFloat(50)
        }
      
        enum GameButtons {
            static let bottom = CGFloat(-16)
            static let leading = CGFloat(36)
            static let trailing = CGFloat(-36)
        }
        
        enum GameScore {
            static let top = CGFloat(6)
            static let height = CGFloat(50)
            static let trailing = CGFloat(-36)
        }
        
        enum Cell {
            
            enum Image {
                static let top = CGFloat(5)
                static let leading = CGFloat(5)
                static let bottom = CGFloat(-5)
                static let width = CGFloat(50)
            }
            
            enum Name {
                static let top = CGFloat(5)
                static let leading = CGFloat(8)
                static let bottom = CGFloat(-5)
            }
            
            enum Record {
                static let top = CGFloat(5)
                static let trailing = CGFloat(-15)
                static let bottom = CGFloat(-5)
            }
        }
    }
    
    enum AppStringsConstants {
        
        enum BaseButton {
            static let start = "Start"
            static let records = "Records"
            static let settings = "Settings"
        }
        
        enum DataBase {
            static let avatar = "avatarImage.jpg"
            static let recordsJSON = "recordsSheet.json"
            static let defaultName = "Username"
            
            enum UserDefaultsKeys: String {
                case name = "name"
                case avatar = "avatarImage"
                case selectedCar = "selectedCar"
                case records = "records"
                case selectedBarrier = "selectedBarrier"
            }
            
            enum PickerData {
                enum Cars: String {
                    case car1 = "car1"
                    case car2 = "car2"
                    case car3 = "car3"
                    
                    static var allCases: [String] {
                        return [car1.rawValue, car2.rawValue, car3.rawValue]
                    }
                    
                    static let carIndex = "selectedCarIndex"
                }
                
                enum Barriers: String {
                    
                        case barrier1 = "barrier1"
                        case barrier2 = "barrier2"
                        case barrier3 = "barrier3"
                        
                        static var allCases: [String] {
                            return [barrier1.rawValue, barrier2.rawValue, barrier3.rawValue]
                        }
                    
                    static let barrierIndex = "selectedBarrierIndex"
                    
                }
            }
        }
        enum Images {
            static let defaultPerson = "defaultPerson"
            static let defaultAvatarPath = "Avatars"
        }
        
    }
    
    enum GameConstants {
        static let defaultScore = 0
        
        // GAME SPEED
        static let gameTimer = CGFloat(2)
        
        enum Player {
            enum FramesConstants {
                static let loadPositionConstantYPos = CGFloat(120)
                static let loadPositionCenterX = CGFloat(50)
                static let frameSize = CGSize(width: 100, height: 100)
            }
        }
        
        enum Barrier {
            enum FramesConstants {
                static let originXMax = 100
                static let originYMax = 100
                static let frameSize = CGSize(width: 100, height: 100)
            }
        }
        
        enum GameAlertTexts {
            static let exit = "Выйти"
            static let restart = "Перезапустить игру"
            static let title = "CRASH!"
            static let message = "SUPER CRASH!"
        }
        
        enum RoadConstants {
            enum Colors {
                static let roadLineColor = UIColor.white.cgColor
                static let betweenLine = UIColor.clear.cgColor
            }
            
            enum Values {
                static let roadLineWidth = CGFloat(6)
                static let lineDash: [NSNumber] = [26,8]
                static let roadSpeed = AppResources.GameConstants.gameTimer / 10
                static let roadsideWidth = CGFloat(30)
            }
        }
        
        enum Buttons {
            static let buttonSpeed: TimeInterval = 0.003
            static let buttonOffset = CGFloat(1)
        }
        
    }

}

