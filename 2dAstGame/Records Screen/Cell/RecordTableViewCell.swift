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
    
    private var userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
    
    // MARK: - Flow
    
    func setupUI() {

        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(userRecord)
        
                NSLayoutConstraint.activate([
                    userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                    userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                    
                    userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                    userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: -5),
                    userName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                    userName.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
                    
                    userRecord.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                    userRecord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                    userRecord.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                    userRecord.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
                    
                ])
    }
    
    func configure(_ recordsData: ScoreModel) {
        userName.text = recordsData.name
        userRecord.text = String(recordsData.score)
        
        if let img = recordsData.userImg {
            userImage.image = UIImage(contentsOfFile: img)
        }
        
        userImage.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
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
