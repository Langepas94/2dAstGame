//
//  GameViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

final class GameViewController: UIViewController {
    
    // MARK: - Elements
    
    private let roadSeparatorView: RoadSeparatorAnimated = {
        let road = RoadSeparatorAnimated()
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
        player.contentMode = .scaleAspectFit
        return player
    }()
    

    private let barrierView: UIImageView = {
        let barrier = UIImageView()
        barrier.contentMode = .scaleAspectFit
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
    
    private var buttonSpeedTimer: Timer?
    private var gametimer: Timer?
    private var displayLink: CADisplayLink?
    
    private var fireGifView = UIImageView()
    private var gameAlert: GameAlert = GameAlert()
    private var gameScore: ScoreModel = ScoreModel()
    private var db = DataBase()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        preGameSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnyTimersAndAnimations()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.frame.origin.y = gameButtonsStackView.frame.origin.y - AppResources.GameConstants.Player.FramesConstants.loadPositionConstantYPos
    }
    
    // MARK: - Flow
    func uiSetup() {
        setupRoadUI()
        setupBarrierViewUI()
        setupPlayerViewUI()
        setupGameScoreUI()
        setupGameButtonsUI()
    }
    
    func preGameSetup() {
        gameSetup()
        gameStarter()
    }
}

// MARK: - UI setup

extension GameViewController {
    
    // MARK: Road UI
    private func setupRoadUI() {
        view.addSubview(roadSeparatorView)
        view.addSubview(roadSide)
        roadSeparatorView.frame = view.bounds
        roadSide.frame = view.bounds
    }
    
    // MARK: Barrier UI
    private func setupBarrierViewUI() {
        view.addSubview(barrierView)
        barrierView.frame.origin = .init(x: .random(in: 0...AppResources.GameConstants.Barrier.FramesConstants.originXMax), y: -AppResources.GameConstants.Barrier.FramesConstants.originYMax)
        barrierView.frame.size = AppResources.GameConstants.Barrier.FramesConstants.frameSize
    }
    
    // MARK: Player UI
    private func setupPlayerViewUI() {
        view.addSubview(playerView)
        playerView.center.x = view.center.x - AppResources.GameConstants.Player.FramesConstants.loadPositionCenterX
        playerView.frame.size = AppResources.GameConstants.Player.FramesConstants.frameSize
    }
    
    // MARK: GameScore UI
    private func setupGameScoreUI() {
        view.addSubview(gameScoreView)
        NSLayoutConstraint.activate([
            gameScoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppResources.AppConstraints.GameScore.top),
            gameScoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppResources.AppConstraints.GameScore.trailing),
            gameScoreView.heightAnchor.constraint(equalToConstant: AppResources.AppConstraints.GameScore.height),
            gameScoreView.widthAnchor.constraint(equalToConstant: AppResources.AppConstraints.GameScore.height),
        ])
    }
    
    // MARK: Buttons UI
    private func setupGameButtonsUI() {
        view.addSubview(gameButtonsStackView)
        NSLayoutConstraint.activate([
            gameButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: AppResources.AppConstraints.GameButtons.bottom),
            gameButtonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppResources.AppConstraints.GameButtons.leading),
            gameButtonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: AppResources.AppConstraints.GameButtons.trailing),
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

// MARK: - pre Game setup

extension GameViewController {
    private func gameSetup() {
        if let name: String = db.read(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.name) {
            gameScore = ScoreModel(name: name, score: AppResources.GameConstants.defaultScore)
        }
        
        if let image: String = db.read(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedCar)  {
            let playerStringArray = image.components(separatedBy: "/")
            let playerImage = "carsPlayer/" + playerStringArray[1]
            print(playerImage)
            playerView.image = UIImage(named: playerImage)
        }
        
        if let barrier: String = db.read(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.selectedBarrier) {
            barrierView.image = UIImage(named: barrier)
        }
    }
    

}

// MARK: - Game Flow
extension GameViewController {
    
    private func gameStarter() {
        gameScore.clear()
        self.displayLinkActive()
        self.updateScoreLabel()
        gametimer = Timer.scheduledTimer(withTimeInterval: AppResources.GameConstants.gameTimer, repeats: true, block: { [weak self] timer in
            self?.animationScoreUpdater()
            self?.updateScoreLabel()
        })
    }
    
    private func displayLinkActive() {
        displayLink = CADisplayLink(target: self, selector: #selector(crashChecker))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    private func updateScoreLabel() {
        let texts = "\(gameScore.score)"
        gameScoreView.text = texts
    }
    
    // MARK: Game alert
    private func gameAlertViewPresent() {
        
        gameAlert.showAlert(title: AppResources.GameConstants.GameAlertTexts.title, message: AppResources.GameConstants.GameAlertTexts.message, viewController: self) { action in
            self.db.save(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.records, data: self.gameScore)
            self.fireCrash()
            self.dismiss(animated: true)
        } restartAction: { _ in
            self.db.save(dataType: AppResources.AppStringsConstants.DataBase.UserDefaultsKeys.records, data: self.gameScore)
            self.fireCrash()
            self.resetMovingViewPosition()
            self.gameStarter()
        }
    }
    
    // MARK: Game stops
    private func stopAnyTimersAndAnimations() {
        barrierView.layer.removeAllAnimations()
        roadSeparatorView.stopAllAnimations()
        playerView.stopAnimating()
        playerView.layer.removeAllAnimations()
        invalidateAllTimers()
    }
    
    private func invalidateAllTimers() {
        buttonSpeedTimer?.invalidate()
        buttonSpeedTimer = nil
        gametimer?.invalidate()
        gametimer = nil
        
        DispatchQueue.main.async {
            self.displayLink?.remove(from: .current, forMode: .common)
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
    
    // MARK: reset position
    private func resetMovingViewPosition() {
        barrierView.frame.origin = .init(x: .random(in: 0...AppResources.GameConstants.Barrier.FramesConstants.originXMax), y: -AppResources.GameConstants.Barrier.FramesConstants.originYMax)
        playerView.center.x = view.center.x
        roadSeparatorView.layoutSubviews()
        view.layoutIfNeeded()
    }
    
    private func fireCrash(_ frame: CGRect? = nil) {
         if frame == nil {
             fireGifView.stopAnimating()
             fireGifView.removeFromSuperview()
         } else {
             guard var frame = frame else { return }
             frame.origin.y = frame.origin.y - 80
             fireGifView = UIImageView.fromGif(frame: frame, resourceName: "fire") ?? UIImageView()
             view.addSubview(fireGifView)
             fireGifView.animationDuration = 3
             fireGifView.animationRepeatCount = .max
             fireGifView.startAnimating()
         }
     }
}

// MARK: - Gaming actions

extension GameViewController {
    
    // MARK: Crash
    @objc private func crashChecker()  {
        
        let roadSides = roadSide.roadsideFrames()
        
        let movingFrame = playerView.layer.presentation()?.frame ?? playerView.frame
        let stoneFrame = barrierView.layer.presentation()?.frame ?? barrierView.frame
        
        if movingFrame.intersects(stoneFrame) || movingFrame.intersects(roadSides.0) || movingFrame.intersects(roadSides.1)  {
            barrierView.frame = stoneFrame
            stopAnyTimersAndAnimations()
            fireCrash(movingFrame)
            gameAlertViewPresent()
        }
    }
    
    // MARK: - Score updater
    @objc private func animationScoreUpdater() {
        self.gameScore.score += 1
        let framesEdges = roadSide.roadsideFrameInside()
        self.barrierView.frame.origin = .init(x: .random(in: framesEdges.0...framesEdges.1 - AppResources.GameConstants.Barrier.FramesConstants.frameSize.width), y: -AppResources.GameConstants.Barrier.FramesConstants.frameSize.width)
        UIView.animate(withDuration: AppResources.GameConstants.gameTimer, delay: 0, options: [.curveLinear], animations: {
            self.barrierView.frame.origin.y = self.view.frame.maxY +  AppResources.GameConstants.Barrier.FramesConstants.frameSize.height
        })
    }
    
    // MARK: Button's and actions
    
    @objc private func buttonLeftLongPressed() {
        buttonSpeedTimer = Timer.scheduledTimer(timeInterval: AppResources.GameConstants.Buttons.buttonSpeed, target: self, selector: #selector(moveViewLeft), userInfo: nil, repeats: true)
    }
    
    @objc private func buttonRightLongPressed() {
        buttonSpeedTimer = Timer.scheduledTimer(timeInterval: AppResources.GameConstants.Buttons.buttonSpeed, target: self, selector: #selector(moveViewRight), userInfo: nil, repeats: true)
    }
    
    @objc private func buttonReleased() {
        buttonSpeedTimer?.invalidate()
        buttonSpeedTimer = nil
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
