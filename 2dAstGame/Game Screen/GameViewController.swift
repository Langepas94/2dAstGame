//
//  GameViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    var roadSeparatorView = RoadSeparatorAnimated(frame: .zero, speed: 0.23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameLayers()
    }
    
}

// MARK: - Game setup

extension GameViewController {
    func setupGameLayers() {
        roadSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roadSeparatorView)
        
        roadSeparatorView.frame = view.bounds
    }
}
