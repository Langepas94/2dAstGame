//
//  GameAlert.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 05.10.2023.
//

import Foundation
import UIKit

class GameAlert {
    typealias AlertCompletionHandler = (UIAlertAction) -> Void
       
       func showAlert(title: String, message: String, viewController: UIViewController, exitAction: @escaping AlertCompletionHandler, restartAction: @escaping AlertCompletionHandler) {
           
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let exitAction = UIAlertAction(title: "Выйти", style: .default, handler: exitAction)
           alertController.addAction(exitAction)
           
           let restartAction = UIAlertAction(title: "Restart game", style: .destructive, handler: restartAction)
           alertController.addAction(restartAction)
           
           viewController.present(alertController, animated: true, completion: nil)
       }

}
