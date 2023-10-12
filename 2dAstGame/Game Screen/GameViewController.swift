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
    private let movingView = UIImageView()
    private let stoneBreaker = UIView()
    private let gameScoreView = UILabel()
    private var timer: Timer?
    private var gameAlert = GameAlert()
    private var gametimer: Timer?
    private var displayLink: CADisplayLink?
    private var gameScore: ScoreModel = ScoreModel(name: "Default Player", score: 0)
    
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
        invalidateAllTimers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayLinkActive()
        gameStarter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        movingView.frame.origin.y = stackView.frame.origin.y - 120
    }
    
    func updateLabel() {
        let texts = "\(gameScore.score)"
        gameScoreView.text = texts
        
    }
}

// MARK: - Game setup

extension GameViewController {
    
    func setupGameLayers() {
        gameScoreView.text = "0"
        roadSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        roadSide.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(roadSeparatorView)
        view.addSubview(roadSide)
        view.addSubview(movingView)
        view.addSubview(stackView)
        view.addSubview(stoneBreaker)
        view.addSubview(gameScoreView)
        stoneBreaker.backgroundColor = .blue
        movingView.image = UIImage(named: "car2")
        
        roadSeparatorView.frame = view.bounds
        roadSide.frame = view.bounds
    }
    
    func gameStarter() {
        gameScore.clear()
        self.updateLabel()
        gametimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.animationsTimer()
            self.updateLabel()
        })
        
    }
    
    func setupGameView() {
        
        //        movingView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stoneBreaker.translatesAutoresizingMaskIntoConstraints = false
        gameScoreView.translatesAutoresizingMaskIntoConstraints = false
        gameScoreView.numberOfLines = 0
        gameScoreView.textColor = .white
        gameScoreView.font = .systemFont(ofSize: 20)
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -36),
            
            gameScoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            gameScoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            gameScoreView.heightAnchor.constraint(equalToConstant: 50),
            gameScoreView.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        movingView.center.x = view.center.x - 50
        movingView.frame.size = CGSize(width: 100, height: 100)
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
    
    func gameAlertAlarm() {
        gameAlert.showAlert(title: "CRASH!", message: "SUPER CRASH!", viewController: self) { [weak self] action in
            self?.dismiss(animated: true)
        } restartAction: { [weak self] action in
            self?.displayLinkActive()
            self?.gameStarter()
            self?.resetMovingViewPosition()
        }
    }
}

// MARK: - Game Logic Flow

extension GameViewController {
    
    // MARK: Crash
    @objc func crashChecker()  {
        
        let roadSides = roadSide.roadsideFrames()
        
        let movingFrame = movingView.layer.presentation()?.frame ?? CGRect(x: 0, y: 0, width: 100, height: 100)
        let stoneFrame = stoneBreaker.layer.presentation()?.frame ?? CGRect(x: 200, y: 0, width: 100, height: 100)
        
        if movingFrame.intersects(stoneFrame) || movingFrame.intersects(roadSides.0) || movingFrame.intersects(roadSides.1)  {
            stoneBreaker.frame = stoneFrame
            stopAllAnimations()
            invalidateAllTimers()
            gameAlertAlarm()
        }
    }
    
    func stopAllAnimations() {
        stoneBreaker.layer.removeAllAnimations()
        roadSeparatorView.stopAllAnimations()
    }
    
    func invalidateAllTimers() {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink?.invalidate()
        displayLink = nil
        timer?.invalidate()
        timer = nil
        gametimer?.invalidate()
        gametimer = nil
    }
    
    // MARK: Reset position
    
    func resetMovingViewPosition() {
        stoneBreaker.frame.origin = .init(x: .random(in: 0...100), y: -100)
        movingView.center.x = view.center.x
        roadSeparatorView.layoutSubviews()
        view.layoutIfNeeded()
    }
    
    @objc func animationsTimer() {
        self.gameScore.score += 1
        let framesEdges = roadSide.roadsideFrameInside()
        self.stoneBreaker.frame.origin = .init(x: .random(in: framesEdges.0...framesEdges.1 - 100), y: -100)
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
        
        guard movingView.frame.origin.x > 0 else {
            return
        }
        movingView.frame.origin.x -= 1
    }
    
    @objc private func moveViewRight() {
        
        guard movingView.frame.maxX < view.bounds.width else {
            return
        }
        movingView.frame.origin.x += 1
    }
}
