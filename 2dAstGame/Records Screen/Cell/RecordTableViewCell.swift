//
//  RecordTableViewCell.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import UIKit

final class RecordTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: RecordTableViewCell.self)
    
    // MARK: - Elements
    
    private var userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Image.width / 2
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var userName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = AppResources.Screens.RecordsScreen.Colors.Cell.mainText
        name.font = AppResources.UniqueConstants.Fonts.cellFont
        return name
    }()
    
    private var userRecord: UILabel = {
        let record = UILabel()
        record.translatesAutoresizingMaskIntoConstraints = false
        record.textColor = AppResources.Screens.RecordsScreen.Colors.Cell.mainText
        record.font = AppResources.UniqueConstants.Fonts.cellFont
        return record
    }()
    
    
    // MARK: - Flow
    
   private func setupUI() {
        
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(userRecord)
        backgroundColor = .white.withAlphaComponent(0.6)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Image.top),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Image.leading),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Image.bottom),
            userImage.widthAnchor.constraint(equalToConstant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Image.width),
            userImage.heightAnchor.constraint(equalToConstant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Image.width),
            
            userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Name.top),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Name.leading),
            userName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Name.bottom),
            userName.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            userRecord.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Record.top),
            userRecord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Record.trailing),
            userRecord.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppResources.Screens.RecordsScreen.ConstraintsAndSizes.Cell.Record.bottom),
            userRecord.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
        ])
    }
    
    //MARK: - Configure
    
    func configure(_ recordsData: ScoreModel) {
        userName.text = recordsData.name
        userRecord.text = String(recordsData.score)
        
        let img = recordsData.userImg ?? AppResources.UniqueConstants.DataBase.Images.defaultPerson
        
        if  img == AppResources.UniqueConstants.DataBase.Images.defaultPerson  {
            userImage.image = UIImage(named: img)
        } else {
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
