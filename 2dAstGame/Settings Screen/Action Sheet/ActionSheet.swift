//
//  ActionSheet.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 03.10.2023.
//

import Foundation
import UIKit
import Photos
import AVFoundation

final class ActionSheet: UIAlertController {
    
    // MARK: - Variables
    private let imagePicker = UIImagePickerController()
    
    // MARK - Flow
    
    static func showImagePicker(handler: @escaping (UIImagePickerController.SourceType) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Выберите источник", message: "Нам нужен доступ", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch cameraAuthorizationStatus {
            case .authorized:
                handler(.camera)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        handler(.camera)
                    } else {
                        print("Отказано в доступе к камере")
                    }
                }
            case .denied, .restricted:
                print("Отказано в доступе к камере")
            @unknown default:
                break
            }
        }
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            let galleryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            
            switch galleryAuthorizationStatus {
            case .authorized, .limited:
                handler(.photoLibrary)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized || status == .limited {
                        handler(.photoLibrary)
                    } else {
                        print("Отказано в доступе к галерее")
                    }
                }
            case .denied, .restricted:
                print("Отказано в доступе к галерее")
            @unknown default:
                break
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
}
