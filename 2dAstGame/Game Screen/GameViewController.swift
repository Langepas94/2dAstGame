//
//  GameViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    private let roadSeparatorView = RoadSeparatorAnimated(frame: .zero, speed: 0.23)
    private let roadSide = RoadSideView(frame: .zero, roadsideWidth: 80)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameLayers()
    }
    
}

// MARK: - Game setup

extension GameViewController {
    func setupGameLayers() {
        roadSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        roadSide.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roadSeparatorView)
        view.addSubview(roadSide)
        
        roadSeparatorView.frame = view.bounds
        roadSide.frame = view.bounds
    }
}
