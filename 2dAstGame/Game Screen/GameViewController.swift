//
//  GameViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Variables
    
    private let roadSeparatorView: RoadSeparatorAnimated = {
        let road = RoadSeparatorAnimated(frame: .zero, speed: AppResources.GameConstants.RoadConstants.Values.roadSpeed)
        road.translatesAutoresizingMaskIntoConstraints = false
        return road
    }()
    
    private let roadSide: RoadSideView  = {
        let roadSide = RoadSideView(frame: .zero, roadsideWidth: AppResources.GameConstants.RoadConstants.Values.roadsideWidth)
        roadSide.translatesAutoresizingMaskIntoConstraints = false
        return roadSide
    }()
    
    private let gameButtonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let playerView: UIImageView = {
        let player = UIImageView()
        return player
    }()
    
    
    private let barrierView: UIImageView = {
        let barrier = UIImageView()
        return barrier
    }()
    
    private let gameScoreView: UILabel = {
        let gameScore = UILabel()
        gameScore.text = String(AppResources.GameConstants.defaultScore)
        gameScore.numberOfLines = 0
        gameScore.textColor = .white
        gameScore.font = AppResources.AppFonts.gameScore
        gameScore.translatesAutoresizingMaskIntoConstraints = false
        return gameScore
    }()
    
    private var timer: Timer?
    private var gameAlert = GameAlert()
    private var gametimer: Timer?
    private var displayLink: CADisplayLink?
    private var gameScore: ScoreModel = ScoreModel()
    private var db = DataBase()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoad()
        gameUISetup()
        
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
        playerView.frame.origin.y = gameButtonsStackView.frame.origin.y - AppResources.GameConstants.Player.FramesConstants.loadPositionConstantYPos
    }
}

// MARK: - RoadUI Setup
extension GameViewController {
    func setupRoad() {
        view.addSubview(roadSeparatorView)
        view.addSubview(roadSide)
        roadSeparatorView.frame = view.bounds
        roadSide.frame = view.bounds
    }
}

// MARK: - GameUI Setup

extension GameViewController {
    func gameUISetup() {
        if let name: String = db.read(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.name) {
            gameScore = ScoreModel(name: name, score: AppResources.GameConstants.defaultScore)
        }
        
        setupMovingView()
        setupBarrierView()
        view.addSubview(gameButtonsStackView)
        view.addSubview(gameScoreView)
        
        NSLayoutConstraint.activate([
            gameButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: AppResources.AppConstraints.GameButtons.bottom),
            gameButtonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppResources.AppConstraints.GameButtons.leading),
            gameButtonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: AppResources.AppConstraints.GameButtons.trailing),
            
            gameScoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppResources.AppConstraints.GameScore.top),
            gameScoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppResources.AppConstraints.GameScore.trailing),
            gameScoreView.heightAnchor.constraint(equalToConstant: AppResources.AppConstraints.GameScore.height),
            gameScoreView.widthAnchor.constraint(equalToConstant: AppResources.AppConstraints.GameScore.height),
        ])
        
        let buttonLeft = UIButton(type: .system)
        
        buttonLeft.setTitle("← Налево", for: .normal)
        buttonLeft.addTarget(self, action: #selector(buttonLeftLongPressed), for: .touchDown)
        buttonLeft.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        
        let buttonRight = UIButton(type: .system)
        
        buttonRight.setTitle("Направо →", for: .normal)
        buttonRight.addTarget(self, action: #selector(buttonRightLongPressed), for: .touchDown)
        buttonRight.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        
        gameButtonsStackView.addArrangedSubview(buttonLeft)
        gameButtonsStackView.addArrangedSubview(buttonRight)
    }
}

// MARK: - Moving view Setup
extension GameViewController {
    
    func setupMovingView() {
        view.addSubview(playerView)
        playerView.center.x = view.center.x - AppResources.GameConstants.Player.FramesConstants.loadPositionCenterX
        playerView.frame.size = AppResources.GameConstants.Player.FramesConstants.frameSize
        
        if let image: String = db.read(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedCar)  {
            playerView.image = UIImage(named: image)
        }
    }
}

// MARK: - Barrier view Setup
extension GameViewController {
    func setupBarrierView() {
        view.addSubview(barrierView)
        barrierView.frame.origin = .init(x: .random(in: 0...AppResources.GameConstants.Barrier.FramesConstants.originXMax), y: -AppResources.GameConstants.Barrier.FramesConstants.originYMax)
        barrierView.frame.size = AppResources.GameConstants.Barrier.FramesConstants.frameSize
        if let barrier: String = db.read(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedBarrier) {
            barrierView.image = UIImage(named: barrier)
        }
    }
}

// MARK: - Game logic
extension GameViewController {
    
    func gameStarter() {
        gameScore.clear()
        self.updateScoreLabel()
        gametimer = Timer.scheduledTimer(withTimeInterval: AppResources.GameConstants.gameTimer, repeats: true, block: { timer in
            self.animationsTimer()
            self.updateScoreLabel()
        })
    }
    
    func displayLinkActive() {
        displayLink = CADisplayLink(target: self, selector: #selector(crashChecker))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    func updateScoreLabel() {
        let texts = "\(gameScore.score)"
        gameScoreView.text = texts
    }
    
    func stopAllAnimations() {
        barrierView.layer.removeAllAnimations()
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
    
    func gameAlertViewPresent() {
        self.db.save(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.records, data: self.gameScore)
        gameAlert.showAlert(title: AppResources.GameConstants.GameAlertTexts.title, message: AppResources.GameConstants.GameAlertTexts.message, viewController: self) { [weak self] action in
            self?.dismiss(animated: true)
        } restartAction: { [weak self] action in
            self?.displayLinkActive()
            self?.gameStarter()
            self?.resetMovingViewPosition()
        }
    }
    
    func resetMovingViewPosition() {
        barrierView.frame.origin = .init(x: .random(in: 0...AppResources.GameConstants.Barrier.FramesConstants.originXMax), y: -AppResources.GameConstants.Barrier.FramesConstants.originYMax)
        playerView.center.x = view.center.x
        roadSeparatorView.layoutSubviews()
        view.layoutIfNeeded()
    }
}

// MARK: - Game flow

extension GameViewController {
    
    // MARK: Crash
    @objc func crashChecker()  {
        
        let roadSides = roadSide.roadsideFrames()
        
        let movingFrame = playerView.layer.presentation()?.frame ?? playerView.frame
        let stoneFrame = barrierView.layer.presentation()?.frame ?? barrierView.frame
        
        if movingFrame.intersects(stoneFrame) || movingFrame.intersects(roadSides.0) || movingFrame.intersects(roadSides.1)  {
            barrierView.frame = stoneFrame
            stopAllAnimations()
            invalidateAllTimers()
            gameAlertViewPresent()
        }
    }
    
    // MARK: - Score update
    @objc func animationsTimer() {
        self.gameScore.score += 1
        let framesEdges = roadSide.roadsideFrameInside()
        self.barrierView.frame.origin = .init(x: .random(in: framesEdges.0...framesEdges.1 - AppResources.GameConstants.Barrier.FramesConstants.frameSize.width), y: -AppResources.GameConstants.Barrier.FramesConstants.frameSize.width)
        UIView.animate(withDuration: AppResources.GameConstants.gameTimer, delay: 0, options: [.curveLinear], animations: {
            self.barrierView.frame.origin.y = self.view.frame.maxY +  AppResources.GameConstants.Barrier.FramesConstants.frameSize.height
            
        })
        
        if gametimer == nil {
            barrierView.layer.removeAllAnimations()
        }
    }
    
    // MARK: Button's and actions
    
    @objc private func buttonLeftLongPressed() {
        timer = Timer.scheduledTimer(timeInterval: AppResources.GameConstants.Buttons.buttonSpeed, target: self, selector: #selector(moveViewLeft), userInfo: nil, repeats: true)
    }
    
    @objc private func buttonRightLongPressed() {
        timer = Timer.scheduledTimer(timeInterval: AppResources.GameConstants.Buttons.buttonSpeed, target: self, selector: #selector(moveViewRight), userInfo: nil, repeats: true)
    }
    
    @objc private func buttonReleased() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func moveViewLeft() {
        
        guard playerView.frame.origin.x > 0 else {
            return
        }
        playerView.frame.origin.x -= AppResources.GameConstants.Buttons.buttonOffset
    }
    
    @objc private func moveViewRight() {
        
        guard playerView.frame.maxX < view.bounds.width else {
            return
        }
        playerView.frame.origin.x += AppResources.GameConstants.Buttons.buttonOffset
    }
}
