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
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.setTitle("Start")
        button.addTarget(self, action: #selector(gameScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var recordsButton: BaseButtonView = {
        let button = BaseButtonView()
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.setTitle("Records")
        button.addTarget(self, action: #selector(recordsScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: BaseButtonView = {
        let button = BaseButtonView()
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.setTitle("Settings")
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
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

extension MainScreenViewController {
    
    func setupUI() {
        view.backgroundColor = AppColors.backgroundColor
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(startButton)
        buttonsStackView.addArrangedSubview(recordsButton)
        buttonsStackView.addArrangedSubview(settingsButton)
        buttonsStackView.frame.size = CGSize(width: 200, height: 200)
        buttonsStackView.center = view.center
    }
}
