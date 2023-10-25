//
//  SettingsViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var userName: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = AppResources.Screens.SettingsScreen.Colors.mainText
        name.textAlignment = .center
        name.font = AppResources.UniqueConstants.Fonts.pixelUsernameFont
        name.adjustsFontSizeToFitWidth = true
        return name
    }()
    
    private let carPicker: CarPickerView = {
        let picker = CarPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let barrierPicker: BarrierPickerView = {
        let picker = BarrierPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let backgroundImage: UIImageView = {
        let bg = UIImageView(image: UIImage(named: AppResources.UniqueConstants.ColorsImages.backgroundSecondImage))
   
        bg.contentMode = .center
        return bg
    }()
    
    private let db = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupUI()
        gesturesSettings()
        setupDelegates()
    }
    
    // MARK - LayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        userName.underlined()
    }
    
    // MARK: - Flow
    
    private func gesturesSettings() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func selectImage() {
        
        let alert = ActionSheet.showImagePicker { sourceType in
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    imagePicker.sourceType = sourceType
                    self.present(imagePicker, animated: true)
                } else {
                    print("Ваша камера не работает")
                }
            }
        }
        present(alert, animated: true)
    }
    
    private func setupDelegates() {
        userName.delegate = self
    }
}

// MARK: - Setup UI

extension SettingsViewController {
    private func setupUI() {
        view.addSubview(avatarImageView)
        view.addSubview(userName)
        view.addSubview(carPicker)
        view.addSubview(barrierPicker)
       
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        if let image: UIImage = db.read(dataType: .avatar) {
            avatarImageView.image = image
        }
        
        backgroundImage.frame = view.frame
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.Image.top),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.Image.leading),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.Image.trailing),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            userName.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.Name.top),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.Name.leading),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.Name.trailing),
            
            carPicker.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.CarPicker.top),
            carPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carPicker.heightAnchor.constraint(equalToConstant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.CarPicker.height),
            
            barrierPicker.topAnchor.constraint(equalTo: carPicker.bottomAnchor, constant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.BarrierPicker.top),
            barrierPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            barrierPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            barrierPicker.heightAnchor.constraint(equalToConstant: AppResources.Screens.SettingsScreen.ConstraintsAndSizes.BarrierPicker.height),
            barrierPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        blurEffect()
    }
    
    func blurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let viewEffect = UIVisualEffectView(effect: blurEffect)
        viewEffect.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        viewEffect.frame = backgroundImage.frame
        backgroundImage.addSubview(viewEffect)
    }
}

// MARK: UIImagePicker

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImageView.image = pickedImage
            db.save(dataType: .avatar, data: pickedImage)
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - UItextField delegate

extension SettingsViewController: UITextFieldDelegate {
    private func setupTextField() {
        let name: String = db.read(dataType: .name) ?? AppResources.UniqueConstants.DataBase.defaultName
        userName.text = name
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        db.save(dataType: .name, data: textField.text)
        setupTextField()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        db.save(dataType: .name, data: userName.text)
        view.endEditing(true)
    }
}
