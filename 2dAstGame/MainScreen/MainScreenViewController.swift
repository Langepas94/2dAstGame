//
//  ViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 28.09.2023.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    lazy var startButton: BaseButtonView = {
        let button = BaseButtonView()
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.setTitle("Start")
        return button
    }()
    
    lazy var recordsButton: BaseButtonView = {
        let button = BaseButtonView()
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.setTitle("Records")
        return button
    }()
    
    lazy var settingsButton: BaseButtonView = {
        let button = BaseButtonView()
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.setTitle("Settings")
        return button
    }()
    
    let buttonsStackView: UIStackView = {
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
