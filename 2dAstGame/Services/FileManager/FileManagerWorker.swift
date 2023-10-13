//
//  FileManagerWorker.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 13.10.2023.
//

import Foundation
import UIKit

class FileManagerWorker {
    
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    func saveImage(_ image: UIImage) {
        guard let filePath = filePath else { return }
        let fileURL = filePath.appendingPathComponent("avatarImage.jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.3) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {}
        
    }
    
    func loadImage() -> UIImage? {
        guard let filePath = filePath else { return nil }
        let fileURL = filePath.appendingPathComponent("avatarImage.jpg")
        return UIImage(contentsOfFile: fileURL.path) ?? nil
    }
    
    func saveRecords(_ record: ScoreModel) {
        guard record.score > 0 else { return }
        guard let filePath = filePath else { return }
        let fileURL = filePath.appendingPathComponent("recordsSheet.json")
        
        var records: [ScoreModel] = []
        let imagePath = getAvatarPath(record.name)
  
        do {
            
            if FileManager.default.fileExists(atPath: fileURL.path), let data = try? Data(contentsOf: fileURL) {
                records = try JSONDecoder().decode([ScoreModel].self, from: data)
            }
            
            var recordWriting = record
            recordWriting.userImg = imagePath
            records.append(recordWriting)
            saveRecordAvatar(recordWriting.name)
            
            let encodedRecords = try JSONEncoder().encode(records)
            try encodedRecords.write(to: fileURL)
            
        } catch {
            
            print("Ошибка при сохранении записей: \(error)")
        }
    }
    
    
    func loadRecords() -> [ScoreModel]? {
        guard let filePath = filePath else { return nil }
        
        let fileURL = filePath.appendingPathComponent("recordsSheet.json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            
            let decoder = JSONDecoder()
            var records = try decoder.decode([ScoreModel].self, from: data)
            records = records.map { model in
                var copy = model
                copy.userImg = getAvatarPath(model.name)
                return copy
            }
            return records
        } catch {
            print("Ошибка при чтении файла JSON: \(error)")
            return nil
        }
    }
    
    func getAvatarPath(_ userName: String) -> String {
        guard let filePath = filePath else { return ""}
        let avatarDirectory = filePath.appendingPathComponent("Avatars")
        let userAvatarDirectory = avatarDirectory.appendingPathComponent(userName)
        let avatarFilename = userAvatarDirectory.appendingPathComponent("\(userName).jpg")
        return avatarFilename.path
    }
    
    func saveRecordAvatar(_ userName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let avatarDirectory = documentsDirectory.appendingPathComponent("Avatars")
        
        if !FileManager.default.fileExists(atPath: avatarDirectory.path) {
            try? FileManager.default.createDirectory(at: avatarDirectory, withIntermediateDirectories: false, attributes: nil)
        }
        
        let userAvatarDirectory = avatarDirectory.appendingPathComponent(userName)
        
        if !FileManager.default.fileExists(atPath: userAvatarDirectory.path) {
            try? FileManager.default.createDirectory(at: userAvatarDirectory, withIntermediateDirectories: false, attributes: nil)
        }
        
        let avatarFilename = userAvatarDirectory.appendingPathComponent("\(userName).jpg")
        
        if let imageToSave: UIImage = loadImage() {
            let scaledImage = imageToSave.cropToSize(CGSize(width: 100, height: 100))
            let roundedImage = scaledImage?.makeCircularImage()
            if let data = roundedImage?.jpegData(compressionQuality: 0.5) {
                try? data.write(to: avatarFilename)
            }
        }
    }
}
