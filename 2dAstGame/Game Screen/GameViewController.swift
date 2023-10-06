//
//  GameViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    private let roadSeparatorView = RoadSeparatorAnimated(frame: .zero, speed: 0.23)
    private let roadSide = RoadSideView(frame: .zero, roadsideWidth: 30)
    private let stackView = UIStackView()
    private let movingView = UIView()
    private var timer: Timer?
    private var gameAlert = GameAlert()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameLayers()
        setupGameView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer = nil
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
    
    func setupGameView() {
        movingView.backgroundColor = UIColor.red
        movingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movingView)
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -36),
            
            movingView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -36),
            movingView.heightAnchor.constraint(equalToConstant: 100),
            movingView.widthAnchor.constraint(equalToConstant: 100),
            movingView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
        
        let buttonLeft = UIButton(type: .system)
        
        buttonLeft.setTitle("← Налево", for: .normal)
        buttonLeft.addTarget(self, action: #selector(buttonLeftLongPressed), for: .touchDown)
        buttonLeft.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        
        let buttonRight = UIButton(type: .system)
        
        buttonRight.setTitle("Направо →", for: .normal)
        buttonRight.addTarget(self, action: #selector(buttonRightLongPressed), for: .touchDown)
        buttonRight.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        
        stackView.addArrangedSubview(buttonLeft)
        stackView.addArrangedSubview(buttonRight)
        
    }
    
    
    
    
}

// MARK: - Game Logic Flow

extension GameViewController {
    // MARK: Crash
    func crashChecker()  {
        
        let frames = roadSide.roadsideFrames()
        
        print(frames)
        print(movingView.frame)
        frames.forEach { frame in
            if movingView.frame.intersects(frame) {
                timer?.invalidate()
                timer = nil
                gameAlert.showAlert(title: "CRASH!", message: "SUPER CRASH!", viewController: self) { [weak self] action in
                    
                    self?.dismiss(animated: true)
                    
                } restartAction: { [weak self] action in
                    
                    self?.resetMovingViewPosition()
                    self?.roadSeparatorView.layoutSubviews()
                }
                
                roadSeparatorView.stopAllAnimations()
                
            } else {
                print("normal")
            }
        }
    }
    
    // MARK: Reset position
    
    func resetMovingViewPosition() {
        
        movingView.center.x = view.center.x
        
        view.layoutIfNeeded()
    }
    
    // MARK: Button's and actions
    
    @objc private func buttonLeftLongPressed() {
        timer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(moveViewLeft), userInfo: nil, repeats: true)
        
    }
    
    @objc private func buttonRightLongPressed() {
        timer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(moveViewRight), userInfo: nil, repeats: true)
    }
    
    @objc private func buttonReleased() {
        
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func moveViewLeft() {
        crashChecker()
        guard movingView.frame.origin.x > 0 else {
            return
        }
        movingView.frame.origin.x -= 1
        
    }
    
    @objc private func moveViewRight() {
        crashChecker()
        guard movingView.frame.maxX < view.bounds.width else {
            return
        }
        movingView.frame.origin.x += 1
    }
}
