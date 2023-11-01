//
//  UIImage + extension.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 13.10.2023.
//

import Foundation
import UIKit

extension UIImage {
    func cropToSize(_ targetSize: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        self.draw(in: rect)
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage
    }
    
    func makeCircularImage() -> UIImage? {
        let imageWidth = size.width
        let imageHeight = size.height
        let diameter = min(imageWidth, imageHeight)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 1.0)
        
        let clippingPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        clippingPath.addClip()
        
        let drawRect = CGRect(x: (diameter - imageWidth) / 2, y: (diameter - imageHeight) / 2, width: imageWidth, height: imageHeight)
        
        draw(in: drawRect)
        
        let circularImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return circularImage
    }
}
