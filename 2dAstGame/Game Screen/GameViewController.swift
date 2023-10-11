//
//  GameViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Variables
    
    private let roadSeparatorView = RoadSeparatorAnimated(frame: .zero, speed: 0.23)
    private let roadSide = RoadSideView(frame: .zero, roadsideWidth: 30)
    private let stackView = UIStackView()
    private let movingView = UIView()
    private let stoneBreaker = UIView()
    private var timer: Timer?
    private var gameAlert = GameAlert()
    var gametimer: Timer?
    private var displayLink: CADisplayLink?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameLayers()
        setupGameView()
        
    }
    
    func displayLinkActive() {
        displayLink = CADisplayLink(target: self, selector: #selector(crashChecker))
        displayLink?.add(to: .main, forMode: .default)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer = nil
        displayLink?.invalidate()
        displayLink = nil
        gametimer = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayLinkActive()
        gameBreaker()
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
    
    func gameBreaker() {
        
//        gametimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(animationsTimer), userInfo: nil, repeats: true)
        
        gametimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.animationsTimer()
        })
    }
    
    func setupGameView() {
        movingView.backgroundColor = .red
        stoneBreaker.backgroundColor = .blue
        
        movingView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stoneBreaker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movingView)
        view.addSubview(stackView)
        view.addSubview(stoneBreaker)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -36),
            
            movingView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -36),
            movingView.heightAnchor.constraint(equalToConstant: 100),
            movingView.widthAnchor.constraint(equalToConstant: 100),
            movingView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            //            stoneBreaker.heightAnchor.constraint(equalToConstant: 100),
            //            stoneBreaker.widthAnchor.constraint(equalToConstant: 100),
            
            //            stoneBreaker.topAnchor.constraint(equalTo: view.topAnchor, constant: -100)
        ])
        
        stoneBreaker.frame.origin = .init(x: .random(in: 0...100), y: -100)
        stoneBreaker.frame.size = CGSize(width: 100, height: 100)
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
    @objc func crashChecker()  {
        
        let frames = roadSide.roadsideFrames()
        
        let movingFrame = movingView.layer.presentation()?.frame ?? CGRect(x: 0, y: 0, width: 100, height: 100)
        let stoneFrame = stoneBreaker.layer.presentation()?.frame ?? CGRect(x: 200, y: 0, width: 100, height: 100)
        
        if movingFrame.intersects(stoneFrame) {
            stoneBreaker.frame = stoneFrame
            stoneBreaker.layer.removeAllAnimations()
            displayLink?.remove(from: .current, forMode: .common)
            displayLink?.invalidate()
            displayLink = nil
            timer?.invalidate()
            timer = nil
            gametimer?.invalidate()
            gametimer = nil
            
            gameAlert.showAlert(title: "CRASH!", message: "SUPER CRASH!", viewController: self) { [weak self] action in
                print("end")
                self?.dismiss(animated: true)
            } restartAction: { [weak self] action in
                self?.displayLinkActive()
                self?.stoneBreaker.frame.origin = .init(x: 0, y: -100)
                self?.gameBreaker()
                self?.resetMovingViewPosition()
                self?.roadSeparatorView.layoutSubviews()
            }
            roadSeparatorView.stopAllAnimations()
        }
        frames.forEach { frame in
            if movingView.frame.intersects(frame) {
                stoneBreaker.layer.removeAllAnimations()
                displayLink?.remove(from: .current, forMode: .common)
                displayLink?.invalidate()
                displayLink = nil
                timer?.invalidate()
                timer = nil
                gametimer?.invalidate()
                gametimer = nil
                gameAlert.showAlert(title: "CRASH!", message: "SUPER CRASH!", viewController: self) { [weak self] action in
                    print("end")
                  
                    self?.dismiss(animated: true)
                } restartAction: { [weak self] action in
                    self?.displayLinkActive()
                    self?.stoneBreaker.frame.origin = .init(x: 0, y: -100)
                    self?.gameBreaker()
                    self?.resetMovingViewPosition()
                    self?.roadSeparatorView.layoutSubviews()
                }
                roadSeparatorView.stopAllAnimations()
            } else {
                //                print("normal")
            }
        }
    }
    
    // MARK: Reset position
    
    func resetMovingViewPosition() {
        stoneBreaker.frame.origin = .init(x: .random(in: 0...100), y: -100)
        movingView.center.x = view.center.x
        view.layoutIfNeeded()
    }
    
    @objc func animationsTimer() {
        let frames = roadSide.roadsideFrameInside()
        self.stoneBreaker.frame.origin = .init(x: .random(in: frames.0...frames.1 - 100), y: -100)
          UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
              self.stoneBreaker.frame.origin.y = self.view.frame.maxY + 100
          })
        
        if gametimer == nil {
            stoneBreaker.layer.removeAllAnimations()
        }
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
