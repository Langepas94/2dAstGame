//
//  Resources.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import Foundation
import UIKit

enum AppResources {
    
    enum Screens {
        
        enum MainScreen {
            enum Colors {
                static let buttonTitle = UIColor.black
            }
            enum ConstraintsAndSizes {
                static let stackViewSize = CGSize(width: 200, height: 200)
                
                enum BaseButton {
                    static let cornerRadius = CGFloat(20)
                    static let shadowOpacity = Float(0.6)
                    static let shadowOffset = CGSize(width: 3, height: 3)
                    static let shadowRadius = CGFloat(4)
                }
            }
            
            enum StringConstants {
                enum BaseButton {
                    static let start = "Start"
                    static let records = "Records"
                    static let settings = "Settings"
                }
            }
        }
        
        enum SettingsScreen {
            
            enum Colors {
                static let mainText = UIColor.black
            }
            enum Selector {
                enum Colors {
                    static let mainText = UIColor.black
                }
                
                enum Images {
                    static let selectorNext = "SelectorArrows/next"
                    static let selectorPrevious = "SelectorArrows/previous"
                }
            }
            enum ConstraintsAndSizes {
                static let pickerSize = CGSize(width: 100, height: 100)
                
                enum Image {
                    static let top = CGFloat(36)
                    static let leading = CGFloat(56)
                    static let trailing = CGFloat(-56)
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
        }
        
        enum RecordsScreen {
            
            enum Colors {
                enum Cell {
                    static let mainText = UIColor.black
                }
            }
            
            enum ConstraintsAndSizes {
                enum Table {
                    static let heightRow = CGFloat(60)
                    static let heightForHeader = CGFloat(100)
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
        }
        
        enum GameScreen {
            
            enum Colors {
                enum Road {
                    static let roadLineColor = UIColor.white.cgColor
                    static let betweenLine = UIColor.clear.cgColor
                }
            }
            enum GameLogic {
                static let defaultScore = 0
                static let roadSpeed = AppResources.Screens.GameScreen.GameLogic.gameTimer / 10
                // GAME SPEED
                static let gameTimer = CGFloat(1.5)
                enum Buttons {
                    static let buttonSpeed: TimeInterval = 0.003
                    static let buttonOffset = CGFloat(1)
                }
            }
            enum ConstraintsAndSizes {
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
                
                enum Player {
                    static let loadPositionConstantYPos = CGFloat(120)
                    static let loadPositionCenterX = CGFloat(width / 2)
                    fileprivate static let height = 100.0
                    
                    // 1.57 это разрешение сторон, для того чтобы ширина картинки фрейма выставлялась без "запаса" по ширине
                    fileprivate static let width = AppResources.Screens.GameScreen.ConstraintsAndSizes.Player.height / 1.57
                    static let frameSize = CGSize(width: width, height: height)
                }
                
                enum Barrier {
                    static let originXMax = 100
                    static let originYMax = 100
                    static let frameSize = CGSize(width: 100, height: 100)
                }
                
                enum Road {
                    static let roadLineWidth = CGFloat(6)
                    static let lineDash: [NSNumber] = [36,8]
                    static let roadsideWidth = CGFloat(30)
                }
            }
            
            enum StringConstants {
                enum GameAlertTexts {
                    static let exit = "Выйти"
                    static let restart = "Перезапустить игру"
                    static let title = "CRASH!"
                    static let message = "SUPER CRASH!"
                }
            }
        }
    }
    
    enum UniqueConstants {
        enum ColorsImages {
            static let backgroundImage = "wallpaper"
            static let backgroundSecondImage = "wallbg"
            static let backgroundColor = UIColor(red: 248/255, green: 175/255, blue: 74/255, alpha: 1.0)
        }
        
        enum Fonts {
            static let cellFont = UIFont(name: "FRM3216x16", size: 20)
            static let gameScore = UIFont(name: "FRM3216x16", size: 25)
            static let pixelFont = UIFont(name: "FRM3216x16", size: 22)
            static let pixelUsernameFont = UIFont(name: "FRM3216x16", size: 36)
        }
        
        enum DataBase {
            static let avatar = "avatarImage.jpg"
            static let smallAvatar = "smallAvatar.jpg"
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
                    case car1 = "carsSelector/car1"
                    case car2 = "carsSelector/car2"
                    case car3 = "carsSelector/car3"
                    case car4 = "carsSelector/car4"
                    case car5 = "carsSelector/car5"
                    
                    static var allCases: [String] {
                        return [car1.rawValue, car2.rawValue, car3.rawValue, car4.rawValue, car5.rawValue]
                    }
                    
                    static let carIndex = "selectedCarIndex"
                }
                
                enum Barriers: String {
                    
                    case barrier1 = "barriers/stone1"
                    case barrier2 = "barriers/stone2"
                    case barrier3 = "barriers/stone3"
                    case barrier4 = "barriers/stone4"
                    
                    static var allCases: [String] {
                        return [barrier1.rawValue, barrier2.rawValue, barrier3.rawValue, barrier4.rawValue]
                    }
                    static let barrierIndex = "selectedBarrierIndex"
                }
            }
            
            enum Images {
                static let defaultPerson = "defaultPerson"
                static let defaultAvatarPath = "Avatars"
            }
        }
    }
}

