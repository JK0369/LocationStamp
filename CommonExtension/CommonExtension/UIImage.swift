//
//  UIImage.swift
//  ComfortDelGro
//
//  Created by Kaung Htet Win on 9/12/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import UIKit

public extension UIImage {
        
    func scaledImage(scaledToSize newSize: CGSize) -> UIImage {
        let image = self
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
