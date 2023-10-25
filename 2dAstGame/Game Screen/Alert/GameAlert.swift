//
//  GameAlert.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit

final class GameAlert {
    typealias AlertCompletionHandler = (UIAlertAction) -> Void
       
       func showAlert(title: String, message: String, viewController: UIViewController, exitAction: @escaping AlertCompletionHandler, restartAction: @escaping AlertCompletionHandler) {
           
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let exitAction = UIAlertAction(title: AppResources.Screens.GameScreen.StringConstants.GameAlertTexts.exit, style: .default, handler: exitAction)
           alertController.addAction(exitAction)
           
           let restartAction = UIAlertAction(title: AppResources.Screens.GameScreen.StringConstants.GameAlertTexts.restart, style: .destructive, handler: restartAction)
           alertController.addAction(restartAction)
           
           viewController.present(alertController, animated: true, completion: nil)
       }

}
