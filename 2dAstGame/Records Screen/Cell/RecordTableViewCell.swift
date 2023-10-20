//
//  RecordTableViewCell.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: RecordTableViewCell.self)
    
    // MARK: - Elements
    
    private var userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = AppResources.AppConstraints.Cell.Image.width / 2
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var userName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = AppResources.AppScreenUIColors.mainText
        name.font = AppResources.AppFonts.cellFont
        return name
    }()
    
    private var userRecord: UILabel = {
        let record = UILabel()
        record.translatesAutoresizingMaskIntoConstraints = false
        record.textColor = AppResources.AppScreenUIColors.mainText
        record.font = AppResources.AppFonts.cellFont
        return record
    }()
    
    
    // MARK: - Flow
    
    func setupUI() {
        
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(userRecord)
        backgroundColor = .white.withAlphaComponent(0.6)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppResources.AppConstraints.Cell.Image.top),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppResources.AppConstraints.Cell.Image.leading),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppResources.AppConstraints.Cell.Image.bottom),
            userImage.widthAnchor.constraint(equalToConstant: AppResources.AppConstraints.Cell.Image.width),
            userImage.heightAnchor.constraint(equalToConstant: AppResources.AppConstraints.Cell.Image.width),
            
            userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppResources.AppConstraints.Cell.Name.top),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: AppResources.AppConstraints.Cell.Name.leading),
            userName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppResources.AppConstraints.Cell.Name.bottom),
            userName.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            userRecord.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppResources.AppConstraints.Cell.Record.top),
            userRecord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: AppResources.AppConstraints.Cell.Record.trailing),
            userRecord.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppResources.AppConstraints.Cell.Record.bottom),
            userRecord.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
        ])
    }
    
    //MARK: - Configure
    
    func configure(_ recordsData: ScoreModel) {
        userName.text = recordsData.name
        userRecord.text = String(recordsData.score)
        
        let img = recordsData.userImg ?? AppResources.AppStringsConstants.Images.defaultPerson
        
        if  img == AppResources.AppStringsConstants.Images.defaultPerson  {
            userImage.image = UIImage(named: img)
        } else {
            print(img)
            userImage.image = UIImage(contentsOfFile: img)
        }
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
