//
//  ExplosionAnimation.swift
//  Demo
//
//  Created by Artur Rymarz on 21.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import UIKit

public extension UIView {
    public func explode(size: GridSize = GridSize(columns: 10, rows: 10)) {
        guard let screenshot = self.screenshot, !isHidden else {
            return
        }

        let pieces = calculatePieces(for: screenshot, size: size)
        explodeAnimation(with: pieces)
    }


    // TODO: extract some methods between both animations (break glass and explosion)
    private func explodeAnimation(with pieces: [ExplosionPiece]) {
        let animationView = UIView()
        animationView.clipsToBounds = true
        animationView.frame = self.frame
        guard let superview = self.superview else {
            return
        }

        self.isHidden = true
        superview.addSubview(animationView)

        let pieceLayers = showJointPieces(pieces, animationView: animationView)
    }

    // TODO: extract for both animations
    private func showJointPieces(_ pieces: [ExplosionPiece], animationView: UIView) -> [CALayer] {
        var allPieceLayers = [CALayer]()
        for index in 0..<pieces.count {
            let piece = pieces[index]
            let pieceLayer = CALayer()
            pieceLayer.contents = piece.image.cgImage
            pieceLayer.frame = CGRect(x: piece.position.x, y: piece.position.y, width: piece.image.size.width, height: piece.image.size.height)
            animationView.layer.addSublayer(pieceLayer)
            allPieceLayers.append(pieceLayer)
        }

        return allPieceLayers
    }

    private func calculatePieces(for image: UIImage, size: GridSize) -> [ExplosionPiece] {
        var pieces = [ExplosionPiece]()
        let columns = size.columns
        let rows = size.rows

        let singlePieceSize = CGSize(width: image.size.width / CGFloat(columns), height: image.size.height / CGFloat(rows))

        for row in 0..<rows {
            for column in 0..<columns {
                // TODO: wrong scale?
                let position = CGPoint(x: CGFloat(column) * singlePieceSize.width, y: CGFloat(row) * singlePieceSize.height)

                let cropRect = CGRect(origin: position, size: singlePieceSize)
                guard
                    let cgImage = image.cgImage,
                    let pieceCgImage = cgImage.cropping(to: cropRect)
                else {
                    continue
                }

                let pieceImage = UIImage(cgImage: pieceCgImage)
                let piece = ExplosionPiece(position: position, image: pieceImage)
                pieces.append(piece)
            }
        }

        return pieces
    }
}
