//
//  RecordTableViewCell.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: RecordTableViewCell.self)
    
    // MARK: - Variables
    
    private var userName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = AppColors.mainText
        name.font = AppFonts.cellFont
        return name
    }()
    
    private var userRecord: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = AppColors.mainText
        name.font = AppFonts.cellFont
        return name
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Flow
    
    func setupUI() {
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(userName)
        buttonsStackView.addArrangedSubview(userRecord)
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            buttonsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)

        ])
    }
    
    func configure(_ recordsData: RecordModel) {
        userName.text = recordsData.name
        userRecord.text = String(recordsData.score)
        contentView.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
