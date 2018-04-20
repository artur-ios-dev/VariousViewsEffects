//
//  UIViewExtensions.swift
//  Demo
//
//  Created by Artur Rymarz on 20.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import UIKit

extension UIView {
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: bounds, afterScreenUpdates: true)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }

        UIGraphicsEndImageContext()

        return image
    }
}
