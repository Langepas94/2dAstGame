//
//  SettingsViewController.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 02.10.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .orange
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var userName: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = AppResources.AppScreenUIColors.mainText
        name.textAlignment = .center
        name.font = AppResources.AppFonts.usernameFont
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
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    // MARK: - Flow
    
    private func gesturesSettings() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(tapGesture)
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
        view.backgroundColor = AppResources.AppScreenUIColors.backgroundColor
        view.addSubview(imageView)
        view.addSubview(userName)
        view.addSubview(carPicker)
        view.addSubview(barrierPicker)
        
        if let image: UIImage = db.read(dataType: .avatar) {
            imageView.image = image
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppResources.AppConstraints.SettingsScreen.Image.top),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppResources.AppConstraints.SettingsScreen.Image.leading),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppResources.AppConstraints.SettingsScreen.Image.trailing),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: AppResources.AppConstraints.SettingsScreen.Name.top),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppResources.AppConstraints.SettingsScreen.Name.leading),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppResources.AppConstraints.SettingsScreen.Name.trailing),
            
            carPicker.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: AppResources.AppConstraints.SettingsScreen.CarPicker.top),
            carPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carPicker.heightAnchor.constraint(equalToConstant: AppResources.AppConstraints.SettingsScreen.CarPicker.height),
            
            barrierPicker.topAnchor.constraint(equalTo: carPicker.bottomAnchor, constant: AppResources.AppConstraints.SettingsScreen.BarrierPicker.top),
            barrierPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            barrierPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            barrierPicker.heightAnchor.constraint(equalToConstant: AppResources.AppConstraints.SettingsScreen.BarrierPicker.height),
            barrierPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: UIImagePicker

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            
            db.save(dataType: .avatar, data: pickedImage)
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - UItextField delegate

extension SettingsViewController: UITextFieldDelegate {
    private func setupTextField() {
        let name: String = db.read(dataType: .name) ?? AppResources.AppStringsConstants.DataBase.defaultName
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
