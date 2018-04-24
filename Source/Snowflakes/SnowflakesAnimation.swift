//
//  SnowflakesAnimation.swift
//  Demo
//
//  Created by Artur Rymarz on 24.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import UIKit

public extension UIView {
    /// Adds snowflakes to your view
    ///
    /// - Parameters:
    ///   - colors: colors of your snowflakes (default: [.white])
    ///   - amount: amount of snowflakes for each color (default: 3)
    ///   - speed: soeed of animation (default: .medium)
    ///   - clipToBounds: should view be clipped to bounds (default: true)
    func addSnowflakes(with colors: [UIColor] = [.white], amount: Int = 3, speed: SnowflakeSpeed = .medium, clipToBounds: Bool = true) {
        self.clipsToBounds = clipToBounds

        let snowflakeEmitter = CAEmitterLayer()

        snowflakeEmitter.emitterPosition = CGPoint(x: center.x, y: -96)
        snowflakeEmitter.emitterShape = kCAEmitterLayerLine
        snowflakeEmitter.emitterSize = CGSize(width: frame.size.width, height: 1)

        var cells = [CAEmitterCell]()
        colors.forEach { color in
            let cell = makeEmitterCell(color: color, amount: amount, speed: speed)
            cells.append(cell)
        }

        snowflakeEmitter.emitterCells = cells
        layer.addSublayer(snowflakeEmitter)
    }

    private func makeEmitterCell(color: UIColor, amount: Int, speed: SnowflakeSpeed) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = Float(amount)
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        let velocity = CGFloat(arc4random_uniform(150) + 150)
        switch speed {
        case .slow:
            cell.velocity = velocity / 3
        default:
            cell.velocity = velocity
        }
        cell.velocityRange = CGFloat(arc4random_uniform(20) + 30)
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = CGFloat(arc4random_uniform(2) + 1)
        cell.spinRange = CGFloat(arc4random_uniform(5) + 1)
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05

        cell.contents = ImagesHelper.imageFor(name: "snowflake")?.cgImage
        return cell
    }
}
