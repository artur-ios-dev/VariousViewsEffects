//
//  GlassBreakAnimation.swift
//  Demo
//
//  Created by Artur Rymarz on 20.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import UIKit

public extension UIView {

    /// Animates the view and hides it afterwards. Does nothing if view has no superview.
    ///
    /// - Parameter size: Describes the number of columns and rows on which the view is broken (default: 10x10)
    /// - Parameter removeAfterCompletion: Removes view from superview after animation completes
    /// - Parameter completion: Animation completion block
    public func breakGlass(size: GridSize = GridSize(columns: 10, rows: 10), removeAfterCompletion: Bool = false, completion: (() -> Void)? = nil) {
        guard let screenshot = self.screenshot, !isHidden else {
            return
        }

        let pieces = calculatePieces(for: screenshot, size: size)
        breakAnimation(with: pieces, columns: size.columns, removeAfterCompletion: removeAfterCompletion, completion: completion)
    }

    private func breakAnimation(with pieces: [[GlassPiece]], columns: Int, removeAfterCompletion: Bool, completion: (() -> Void)?) {
        let animationView = UIView()
        animationView.clipsToBounds = true
        animationView.frame = self.frame
        guard let superview = self.superview else {
            return
        }

        self.isHidden = true
        superview.addSubview(animationView)

        let pieceLayers = showJointPieces(pieces, animationView: animationView)
        animateFalling(allPieceLayers: pieceLayers, columns: CGFloat(columns), animationView: animationView, removeAfterCompletion: removeAfterCompletion, completion: completion)
    }

    private func showJointPieces(_ pieces: [[GlassPiece]], animationView: UIView) -> [CALayer] {
        var allPieceLayers = [CALayer]()
        for row in 0..<pieces.count {
            for column in 0..<pieces[row].count {
                let piece = pieces[row][column]
                let pieceLayer = CALayer()
                pieceLayer.contents = piece.image.cgImage
                pieceLayer.frame = CGRect(x: piece.position.x, y: piece.position.y, width: piece.image.size.width, height: piece.image.size.height)
                animationView.layer.addSublayer(pieceLayer)
                allPieceLayers.append(pieceLayer)
            }
        }

        return allPieceLayers
    }

    private func animateFalling(allPieceLayers: [CALayer], columns: CGFloat, animationView: UIView, removeAfterCompletion: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            animationView.removeFromSuperview()
            if removeAfterCompletion {
                self.removeFromSuperview()
            }

            completion?()
        }
        allPieceLayers.forEach { pieceLayer in
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
            animation.beginTime = CACurrentMediaTime() + (0.3...1.0).random()
            animation.duration = (0.5...1.0).random()
            animation.fillMode = kCAFillModeForwards
            animation.isCumulative = true
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            var trans = pieceLayer.transform
            trans = CATransform3DTranslate(trans, (-1.0...1.0).random() * self.frame.size.width / columns * 0.1, self.frame.size.height + pieceLayer.frame.size.height, 0)
            trans = CATransform3DRotate(trans, (-1.0...1.0).random() * CGFloat.pi * 0.25, 0, 0, 1)
            animation.toValue = NSValue(caTransform3D: trans)
            pieceLayer.add(animation, forKey: nil)
        }
        CATransaction.commit()
    }

    private func calculateCorners(for singlePieceSize: CGSize, gridSize: GridSize) -> [[CGPoint]] {
        func randomShift(for singlePieceSize: CGSize) -> CGFloat {
            return CGFloat((-1.0...1.0).random()) * singlePieceSize.width * (0.3...0.9).random()
        }

        var corners = Array(repeating: Array(repeating: CGPoint(), count: gridSize.columns + 1), count: gridSize.rows + 1)

        for row in 0...gridSize.rows {
            for column in 0...gridSize.columns {
                var point = corners[row][column]
                point.x = singlePieceSize.width * CGFloat(column)
                point.y = singlePieceSize.height * CGFloat(row)
                if column != 0 && column != gridSize.columns {
                    point.x += randomShift(for: singlePieceSize)
                }
                if row != 0 && row != gridSize.rows {
                    point.y += randomShift(for: singlePieceSize)
                }

                corners[row][column] = point
            }
        }

        return corners
    }

    private func calculatePieces(for image: UIImage, size: GridSize) -> [[GlassPiece]] {
        var pieces = [[GlassPiece]]()
        let columns = size.columns
        let rows = size.rows

        let singlePieceSize = CGSize(width: image.size.width / CGFloat(columns), height: image.size.height / CGFloat(rows))
        let corners = calculateCorners(for: singlePieceSize, gridSize: size)

        for row in 0..<rows {
            var rowPieces = [GlassPiece]()
            for column in 0..<columns {
                let lt = corners[row][column]
                let rt = corners[row][column + 1]
                let lb = corners[row + 1][column]
                let rb = corners[row + 1][column + 1]

                let minX = min(lt.x, lb.x)
                let minY = min(lt.y, rt.y)
                let maxX = max(rt.x, rb.x)
                let maxY = max(lb.y, rb.y)

                let block = CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY).integral
                let clipPath = bezierPath(lt: lt, rt: rt, rb: rb, lb: lb, minX: minX, minY: minY, imageScale: image.scale)
                guard let pieceImage = pieceImage(from: image, sourceBlock: block, clipPath: clipPath) else {
                    continue
                }

                let piece = GlassPiece(position: block.origin, corners: [lt, rt, rb, lb], image: pieceImage)
                rowPieces.append(piece)
            }

            pieces.append(rowPieces)
        }

        return pieces
    }

    private func bezierPath(lt: CGPoint, rt: CGPoint, rb: CGPoint, lb: CGPoint, minX: CGFloat, minY: CGFloat, imageScale: CGFloat) -> UIBezierPath {
        let clipPath = UIBezierPath()

        clipPath.move(to: lt)
        clipPath.addLine(to: rt)
        clipPath.addLine(to: rb)
        clipPath.addLine(to: lb)
        clipPath.close()
        clipPath.apply(CGAffineTransform(translationX: -minX, y: -minY))
        clipPath.apply(CGAffineTransform(scaleX: imageScale, y: imageScale))

        return clipPath
    }

    private func pieceImage(from image: UIImage, sourceBlock: CGRect, clipPath: UIBezierPath) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }

        let block = CGRect(x: sourceBlock.origin.x * image.scale,
                           y: sourceBlock.origin.y * image.scale,
                           width: sourceBlock.size.width * image.scale,
                           height: sourceBlock.size.height * image.scale)

        UIGraphicsBeginImageContextWithOptions(block.size, false, 1)
        guard
            let context = UIGraphicsGetCurrentContext(),
            let pieceCgImage = cgImage.cropping(to: block)
        else {
            return nil
        }
        clipPath.addClip()

        let tmpImage = UIImage(cgImage: pieceCgImage)
        tmpImage.draw(at: .zero)

        context.setBlendMode(.copy)
        context.setFillColor(UIColor.clear.cgColor)

        let clippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let clippedCgImage = clippedImage?.cgImage else {
            return nil
        }

        return UIImage(cgImage: clippedCgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}
