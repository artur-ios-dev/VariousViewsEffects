//
//  ImageHelper.swift
//  Pods-Demo
//
//  Created by Artur Rymarz on 24.04.2018.
//

import UIKit

internal class ImagesHelper {
    static func imageFor(name imageName: String) -> UIImage? {
        let bundle = Bundle(for: ImagesHelper.self)

        guard let bundleURL = bundle.url(forResource: "VariousViewsEffects", withExtension: "bundle") else {
            return nil
        }
        let imageBundel = Bundle(url: bundleURL)

        return UIImage(named: imageName, in: imageBundel, compatibleWith: nil)!
    }
}
