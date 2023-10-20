//
//  ViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 28.09.2023.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    private lazy var startButton: BaseButtonView = {
        let button = BaseButtonView()
        button.setTitle(AppResources.AppStringsConstants.BaseButton.start)
        button.addTarget(self, action: #selector(gameScreen), for: .touchUpInside)

        return button
    }()
    
    private lazy var recordsButton: BaseButtonView = {
        let button = BaseButtonView()
        button.setTitle(AppResources.AppStringsConstants.BaseButton.records)
        button.addTarget(self, action: #selector(recordsScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: BaseButtonView = {
        let button = BaseButtonView()
        button.setTitle(AppResources.AppStringsConstants.BaseButton.settings)
        button.addTarget(self, action: #selector(settingsScreen), for: .touchUpInside)
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    private let backgroundImage: UIImageView = {
        let bg = UIImageView(image: UIImage(named: AppResources.AppScreenUIColors.backgroundImage))
        bg.contentMode = .scaleAspectFill
        return bg
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Flow
    
    @objc func settingsScreen() {
        let vc = SettingsViewController()
        self.present(vc, animated: true)
    }
    
    @objc func recordsScreen() {
        let vc = RecordsViewController()
        self.present(vc, animated: true)
    }
    
    @objc func gameScreen() {
        let vc = GameViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

extension MainScreenViewController {
    
    func setupUI() {
//        view.backgroundColor = AppResources.AppScreenUIColors.backgroundColor
        backgroundImage.frame = view.frame
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(startButton)
        buttonsStackView.addArrangedSubview(recordsButton)
        buttonsStackView.addArrangedSubview(settingsButton)
        buttonsStackView.frame.size = AppResources.AppConstraints.MainScreen.stackViewSize
        buttonsStackView.center = view.center
    }
}
