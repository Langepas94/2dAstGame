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
        name.textColor = AppColors.mainText
        name.textAlignment = .center
        name.font = AppFonts.usernameFont
        return name
    }()
    
    private let carPicker: PickerView = {
        let picker = PickerView()
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
        
        present(alert, animated: true)
    }
    
    private func setupDelegates() {
        userName.delegate = self
    }
}

// MARK: - Setup UI

extension SettingsViewController {
    private func setupUI() {
        view.backgroundColor = AppColors.backgroundColor
        view.addSubview(imageView)
        view.addSubview(userName)
        view.addSubview(carPicker)
        
        if let imageData: Data = db.read(dataType: .avatar) {
            let stored = UIImage(data: imageData)
            imageView.image = stored
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppConstraints.topAvatar),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstraints.leadingAvatar),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppConstraints.trailingAvatar),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: AppConstraints.topAvatar),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstraints.leadingAvatar),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: AppConstraints.trailingAvatar),
            
            carPicker.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 16),
            carPicker.leadingAnchor.constraint(equalTo: userName.leadingAnchor, constant: 0),
            carPicker.trailingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 0),
            carPicker.heightAnchor.constraint(equalToConstant: 100)
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
            
            if let imageData = pickedImage.pngData() {
                db.save(dataType: .avatar, data: imageData)
            }
        }
        picker.dismiss(animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    private func setupTextField() {
        
        let name: String = db.read(dataType: .name) ?? "Username"
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
