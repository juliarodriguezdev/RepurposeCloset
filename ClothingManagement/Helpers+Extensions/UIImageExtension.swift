//
//  UIImageExtension.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 10/3/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

extension UIImage {
    func correctlyOrientImage() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        let newImage = UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: .up)
        return newImage
    }
}
